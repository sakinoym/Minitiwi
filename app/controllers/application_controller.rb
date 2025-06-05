class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include SessionsHelper
  include Pagy::Backend

  private

  def require_user_logged_in
    redirect_to login_url unless logged_in?
  end

  def counts(user)
    @count_posts = user.posts.where(flag: 2).count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.likes.where(flag: 2).count
    @count_privates = user.posts.where(flag: 1).count
  end
end
