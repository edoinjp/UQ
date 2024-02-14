class StyledLesson < ApplicationRecord
  belongs_to :lesson

  # Attaches any file-type for the differentiated lesson as content
  has_one_attached :file, dependent: :destroy
end
