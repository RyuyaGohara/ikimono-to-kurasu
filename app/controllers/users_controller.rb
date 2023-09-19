class UsersController < ApplicationController
  def index
    # 新規ユーザーが上に来るように
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    # 新着投稿が上になるように
    @posts = @user.posts.order(created_at: :desc)
  end

  # お気に入り投稿一覧用
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
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

end