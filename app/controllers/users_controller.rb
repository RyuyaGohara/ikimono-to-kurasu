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



private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email)
  end

end