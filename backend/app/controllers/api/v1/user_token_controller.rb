module Api
  module V1
    class UserTokenController < ApplicationController
      rescue_from UserAuth.not_found_exception_class, with: :not_found
      before_action :delete_cookie
      before_action :authenticate, only: [:create]

      # 　ログイン
      def create
        cookies[token_access_key] = cookie_token
        render json: {
          exp: auth.payload[:exp],
          user: entity.as_json(include: %i[posts tags followers followings], methods: [:image_url])
        }
      end

      # 　ログアウト
      def destroy
        head(:ok)
      end

      private

      # NotFoundエラー発生時にヘッダーレスポンスのみを返す
      # status => Rack::Utils::SYMBOL_TO_STATUS_CODE
      def not_found
        head(:not_found)
      end

      # entityが存在しない、entityのパスワードが一致しない場合に404エラーを返す
      def authenticate
        raise UserAuth.not_found_exception_class unless entity.present? && entity.authenticate(auth_params[:password])
      end

      # トークンを発行する
      def auth
        @auth ||= UserAuth::AuthToken.new(payload: { sub: entity.id })
      end

      # メールアドレスからユーザーを返す
      def entity
        @entity ||= User.find_by(email: auth_params[:email])
      end

      def auth_params
        params.require(:auth).permit(:email, :password)
      end

      # クッキーに保存するトークン
      def cookie_token
        {
          value: auth.token,
          expires: Time.at(auth.payload[:exp]),
          secure: Rails.env.production?,
          http_only: false
        }
      end
    end
  end
end
