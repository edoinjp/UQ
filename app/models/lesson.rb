class Lesson < ApplicationRecord
  belongs_to :classroom
  has_many :questions
  has_many :styled_lessons
end
