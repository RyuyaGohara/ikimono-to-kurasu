class Relationship < ApplicationRecord

# フォローしたユーザー
  belongs_to :follower, class_name: "User"
# フォローされたユーザー
  belongs_to :followed, class_name: "User"
  # class_name: "User"でuserテーブルからデータを取得

# 通知機能用
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private
  def create_notifications
    Notification.create(subject: self, user: followed, action_type: :followed_me)
  end

end
