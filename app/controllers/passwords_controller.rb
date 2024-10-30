class PasswordsController < ApplicationController
  before_action :authinticate_user

  def edit
    
  end

  def update
    # Check if password_challenge matches current password
    if current_user.authenticate(password_params[:password_challenge])
      # Remove password_challenge from params for update
      filtered_params = password_params.except(:password_challenge)

      if current_user.update(filtered_params)
        redirect_to edit_password_path, notice: "Your password was updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:alert] = "Current password is incorrect."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :password_chalenge).with_defaults(password_chalenge: "")
  end
end


