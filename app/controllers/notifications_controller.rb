class NotificationsController < ApplicationController
# 通知一覧
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

# 通知の全削除
  def destroy
    @notifications = current_user.notifications.destroy_all
    redirect_to user_notifications_path(current_user)
  end
end
