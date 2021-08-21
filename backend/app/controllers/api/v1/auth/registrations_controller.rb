module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        private

        # ストロングパラメーター設定
        def sign_up_params
          params.permit(:name, :email, :description, :password, :password_confirmation, :image, :admin)
        end

        def account_update_params
          params.permit(:name, :email, :description, :password, :password_confirmation, :image, :admin)
        end
      end
    end
  end
end
