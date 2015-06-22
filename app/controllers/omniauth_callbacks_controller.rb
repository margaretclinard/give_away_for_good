class OmniauthCallbacksController < ApplicationController

  def twitter
    current_user.update_with_twitter_oauth(request.env["omniauth.auth"])
    redirect_to root_path, notice: "You can now post to Twitter."
  end

end