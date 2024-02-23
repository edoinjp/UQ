class StyledLesson < ApplicationRecord
  belongs_to :lesson

  # Attaches all types of content for the differentiated lesson
  has_many_attached :files, dependent: :destroy

  after_create :generate_content

  private

  def generate_content
    openai_api = OpenaiApi.new
    self.content = openai_api.generate_content(lesson.title, style: style)
    save
  end
end
