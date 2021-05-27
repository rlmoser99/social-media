# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  private

    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
                                   :current_password)
    end

    def update_resource(resource, params)
      if current_user.provider == "facebook"
        params.delete("current_password")
        resource.update_without_password(params)
      else
        resource.update_with_password(params)
      end
    end
end
