class RelationshipsController < ApplicationController

# フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
# フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

# フォロー一覧用
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page])
  end
# フォロワー一覧用
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page])
  end

end
