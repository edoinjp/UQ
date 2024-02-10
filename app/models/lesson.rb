class Lesson < ApplicationRecord
  belongs_to :classroom
  has_many :questions, dependant: :destroy
  has_many :styled_lessons, dependant: :destroy
end
