class Lesson < ApplicationRecord
  belongs_to :classroom
  has_many :questions, dependent: :destroy
  has_many :styled_lessons, dependent: :destroy
  # after_create :create_styled_lessons


  def openai_api
    @openai_api ||= OpenaiApi.new
  end


  def create_styled_lessons
    styles = %w[aural kinesthetic reading visual]
    @openai_api = OpenaiApi.new
    # @image_service = GenerateImages.new
    styles.each do |style|
      styled_lesson = styled_lessons.create(style: style)

      if style == 'visual'
        # image_file = @image_service.generate_images(self.title)
        # styled_lesson.files.attach(io: StringIO.new(image_file.read), filename: "#{self.title.parameterize}-#{style}.jpg")
      elsif style == 'aural'
        audio_file = @openai_api.generate_audio(self.content)
        styled_lesson.files.attach(io: StringIO.new(audio_file), filename: "#{self.title.parameterize}-#{style}.mp3")
      elsif style == 'reading'
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
        styled_lesson.content = markdown.render(self.content)
        styled_lesson.save
      end
    end
  end
end
