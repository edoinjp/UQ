class StyledLesson < ApplicationRecord
  belongs_to :lesson
  has_one_attached :file, dependent: :destroy
end
