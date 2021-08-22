module Api
  module V1
    class PasswordsController < ApplicationController
      before_action :set_user

      def update
        current_password = user_params[:current_password]

        if current_password.present?
          if @user.authenticate(current_password)
            if @user.update(user_params)
              render json: { message: 'パスワードを変更しました' }, status: :ok
            else
              render json: @user.errors, status: :unprocessable_entity
            end
          else
            render json: @user.errors.add(:current_password, :wrong), status: :not_found
          end
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(user_params[:user_id])
      end

      def user_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end
    end
  end
end
