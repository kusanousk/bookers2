class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :rate, presence: true, numericality: { in: 1..5 }, on: :create

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
