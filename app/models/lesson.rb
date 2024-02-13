class Lesson < ApplicationRecord
  belongs_to :classroom
  has_many :questions, dependent: :destroy
  has_many :styled_lessons, dependent: :destroy
end
