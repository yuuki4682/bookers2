class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.search(condition, word)
    case condition
    when "perfect_match" then
      @users = Book.where("title LIKE?", "#{word}")
    when "front_match" then
      @users = Book.where("title LIKE?", "#{word}%")
    when "rear_match" then
      @users = Book.where("title LIKE?", "%#{word}")
    when "partial_match" then
      @users = Book.where("title LIKE?", "%#{word}%")
    else
      @users = Book.all
    end
  end
end
