class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    # ページネーション、新規ユーザーが上に来るように
    @users = User.page(params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # ページネーション、新着投稿が上になるように
    @posts = @user.posts.page(params[:page]).order(created_at: :desc)
  end

  # お気に入り投稿一覧用
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page])
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "ユーザー情報の更新ができませんでした"
      render :edit
    end
  end

  # ユーザー退会(削除)用
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to :root #削除に成功すればrootページに戻る
  end



private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email)
  end

# 権限設定
  def is_matching_login_user
    user = User.find(params[:id])
  # ログインユーザーが管理者ユーザーかどうかを確認、管理者ユーザーの場合は通貨させる
    if current_user.admin?
      return
    end
  # ログインユーザーと編集対象のユーザーが一致しない場合はリダイレクト
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end