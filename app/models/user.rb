class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :classrooms, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :students, through: :participations, source: :user

  def full_name
    "#{first_name} #{last_name}"
  end
  def teacher?
    teacher == true
  end
end
