class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include SessionsHelper
  include Pagy::Backend

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
