class SessionsController < ApplicationController
  def new; end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    return false unless @user && @user.authenticate(password)
    session[:user_id] = @user.id
    true
  end
end
