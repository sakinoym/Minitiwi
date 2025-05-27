class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes]
  before_action :set_user_and_counts, only: [:show, :followings, :followers, :likes]

  def index
    @pagy, @users = pagy(User.order(id: :desc))
  end

  def show
    @pagy, @posts = pagy(@user.posts.order(id: :desc))
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def followings
    @pagy, @followings = pagy(@user.followings)
  end

  def followers
    @pagy, @followers = pagy(@user.followers)
  end

  def likes
    @pagy, @likes = pagy(@user.likes)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user_and_counts
    @user = User.find(params[:id])
    counts(@user)
  end
end
