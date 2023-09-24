class PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    # 新着の投稿が上になるように
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿の更新ができませんでした"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

# 権限設定
  def is_matching_login_user
    post = Post.find(params[:id])
# ログインユーザーが管理者ユーザーかどうかを確認、管理者ユーザーの場合は通貨させる
    if current_user.admin?
      return
    end
# ログインユーザーと編集対象のユーザーが一致しない場合はリダイレクト
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
  end

end
