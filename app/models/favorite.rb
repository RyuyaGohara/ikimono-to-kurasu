class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post

# 通知機能用
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private

  def create_notifications
    # 自分の投稿にいいねした場合は通知を作成しない
    return if self.user == self.post.user
    Notification.create(subject: self, user: self.post.user, action_type: :favorited_to_own_post)
  end

end
