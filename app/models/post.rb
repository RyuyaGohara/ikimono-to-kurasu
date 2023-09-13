class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def get_image
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
