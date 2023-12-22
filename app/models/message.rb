class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # 空でない、最大140字まで
  validates :message, presence: true, length: { maximum: 140 }
end
