class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :classrooms, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :students, class_name: 'User', through: :participations, source: :user
  has_many :lessons, through: :classrooms
  # To attach avatar photos to all user seeds
  has_one_attached :photo

  def full_name
    "#{first_name} #{last_name}"
  end
  def teacher?
    teacher == true
  end
  def student?
    !teacher?
  end
end
