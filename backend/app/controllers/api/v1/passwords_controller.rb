module Api
  module V1
    class PasswordsController < ApplicationController
      before_action :authenticate_user

      def update
        current_password = user_params[:current_password]

        if current_password.present?
          if current_user.authenticate(current_password)
            if current_user.update(user_params)
              render json: { message: 'パスワードを変更しました' }, status: :ok
            else
              render json: current_user.errors, status: :unprocessable_entity
            end
          else
            render json: current_user.errors.add(:current_password, :wrong), status: :not_found
          end
        else
          render json: current_user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end
    end
  end
end
