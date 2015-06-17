class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: "Welcome, #{@user.name}"
    else
      flash.alert = "Please fix the errors below to continue."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :company, :street1, :street2, :city, :state, :zip)
  end
end