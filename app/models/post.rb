class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def get_image
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id) if user
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end

end
