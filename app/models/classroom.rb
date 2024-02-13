class Classroom < ApplicationRecord
  belongs_to :user
  has_many :participations, dependent: :destroy
  has_many :students, through: :participations, source: :user

  has_many :lessons, dependent: :destroy
end
