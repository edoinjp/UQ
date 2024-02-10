class Classroom < ApplicationRecord
  belongs_to :user
  has_many :students, class_name: :user, through: :participations, source: :user
  has_many :lessons, dependent: :destroy
end
