class StyledLesson < ApplicationRecord
  belongs_to :lesson

  # Attaches all types of content for the differentiated lesson
  has_many_attached :files, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  # after_create :generate_content

end
