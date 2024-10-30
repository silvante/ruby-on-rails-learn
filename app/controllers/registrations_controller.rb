class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if registration_params[:password] == registration_params[:password_confirmation]
      @user = User.new(registration_params)
    else
      render :new, status: :unprocessable_entity
    end

    if @user.save
      login @user
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
