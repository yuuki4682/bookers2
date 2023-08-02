class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_many :view_counts

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
  
  def self.most_favorited_for_3month
    to = Time.current.at_end_of_day
    from = (to - 3.month).at_beginning_of_day
    includes(:favorited_users).sort_by{|books|books.favorited_users.includes(:favorites).where(created_at: from...to).size}.reverse
  end
  
  scope :created_today, -> {where(created_at: Time.zone.now.all_day)}
  scope :created_yesterday, -> {where(created_at: 1.day.ago.all_day)}
  scope :created_this_week, -> {where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
  scope :created_last_week, -> {where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day)}
  
  #scope :most_favorited, -> {includes(:favorited_users).sort_by{|books|books.favorited_users.includes(:favorites).size}.reverse}
  
end
