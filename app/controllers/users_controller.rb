class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes]

  def index
    @pagy, @users = pagy(User.order(id: :desc))
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(id: :desc))
    counts(@user)
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
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end

  def likes
    @user = User.find(params[:id])
    @pagy, @favoritings = pagy(@user.favoritings)
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
