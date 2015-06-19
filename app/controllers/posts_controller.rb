class PostsController < ApplicationController
  before_filter :load_post
  before_filter :load_user, except: [:new, :create, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show]

  def index
    @posts = @user.posts.all
  end

  def create
    @post.user = current_user
    if @post.save
      redirect_to user_posts_path(current_user), notice: "Your need has been published."
    else
      flash.alert = "Your need could not be published. Please correct the errors below."
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post)
      flash.notice = "#{@post.user.company}'s need has been updated."
    else
      flash.alert = "Please fix the errors below to continue."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(current_user), notice: "#{@post.user.company}'s need has been deleted."
  end

  private

  def load_post
    if params[:id].present?
      @post = Post.find(params[:id])
    else
      @post = Post.new
    end

    if params[:post].present?
      @post.assign_attributes(post_params)
    end
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:category, :description, :date_posted, :deadline)
  end
end
