class UsersController < ApplicationController
  def index
    @users = User.all
    @posts = Post.all
    @posts_canned_goods = Post.where(category:"Canned Goods")
    @posts_books = Post.where(category:"Books")
    @posts_clothes = Post.where(category:"Clothes")
    @posts_furniture = Post.where(category:"Furniture")
    @posts_school = Post.where(category:"School Supplies")
    @posts_technology = Post.where(category:"Technology")
    @posts_other = Post.where(category:"Other")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: "Welcome, #{@user.company}"
    else
      flash.alert = "Please fix the errors below to continue."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to user_path(@user)
      flash.notice = "#{@user.company}'s profile has been updated."
    else
      flash.alert = "Please fix the errors below to continue."
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :company, :bio, :logo, :street1, :street2, :city, :state, :zip)
  end
end