class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :update]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to root_url
    else
      @pagy, @posts = pagy(current_user.feed_posts.order(id: :desc))
      flash.now[:danger] = 'コメントの投稿に失敗しました'
      render 'toppages/index', status: :unprocessable_entity
    end
  end

  def update
    if @post.update(update_flag_params)
      flash[:success] = case @post.flag
        when 1 then '投稿を非公開にしました'
        when 2 then '投稿を公開しました'
      end
    else
      flash[:danger] = '公開情報の更新に失敗しました'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content, :flag, :image)
  end

  def update_flag_params
    params.require(:post).permit(:flag)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
