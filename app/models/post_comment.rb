class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post
  validates :comment, presence: true

# 通知機能用
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private

  def create_notifications
    # 自分の投稿にコメントした場合は通知を作成しない
    return if self.user == self.post.user
    Notification.create(subject: self, user: post.user, action_type: :commented_to_own_post)
  end

end
