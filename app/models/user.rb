class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :books
  has_many :favorites
  has_many :relationships_for_followed,
           class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :relationships_for_follower,
           class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy
  has_many :follows, through: :relationships_for_followed, source: :follow
  has_many :followers, through: :relationships_for_follower, source: :follower
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end
end
