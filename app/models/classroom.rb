class Classroom < ApplicationRecord
belongs_to :user
  has_one :chatroom
  has_many :participations, dependent: :destroy
  has_many :students, through: :participations, source: :user
  has_many :lessons, dependent: :destroy
  validates :name, presence: true
  validates :title, presence: true
end
