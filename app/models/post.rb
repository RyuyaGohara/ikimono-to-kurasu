class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one :notification, as: :subject, dependent: :destroy
# 投稿閲覧数表示
  has_many :view_counts, dependent: :destroy

  validates :title, presence: { message: "タイトルは必須です" }
  validates :body, presence: { message: "本文は必須です" }

  def get_image
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id) if user
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end

end
