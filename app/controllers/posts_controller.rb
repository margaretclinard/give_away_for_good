require "twitter"
require "oauth"

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
      tweet
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

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['0s2juCWWEKw2jfcKBWyaCOSHM']
      config.consumer_secret     = ENV['U9xUklrRH98HxdOa772m6zDOYfn7apQQq7VVIeUyDLFqZo0Eb5']
      config.access_token        = @post.author.oauth_token
      config.access_token_secret = @post.author.oauth_secret
    end
    client.update("We have a new need! Help us by giving back #{@post.category} - #{absolute_url}")
  end

  def absolute_url
    request.base_url  + "/users/1" + request.original_fullpath + "/#{@post.id}"
  end

  def post_params
    params.require(:post).permit(:category, :description, :date_posted, :deadline)
  end
end
