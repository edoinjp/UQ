class Lesson < ApplicationRecord
  belongs_to :classroom
  has_many :questions, dependent: :destroy
  has_many :styled_lessons, dependent: :destroy
  # after_create :create_styled_lessons

  def openai_api
    @openai_api ||= OpenaiApi.new
  end

  def has_supplementary_lessons?
    styled_lessons.supplementary.exists?
  end

  def missing_styles
    all_styles = %w[visual aural reading kinesthetic]
    available_styles = styled_lessons.where(supplementary: true).map(&:style).uniq
    all_styles - available_styles
  end

  def create_styled_lessons(supplementary: false, styles: )
    return if styles.empty?

    @openai_api = OpenaiApi.new
    # @image_service = GenerateImages.new
    styles.each do |style|
      styled_lesson = styled_lessons.create(style: style, supplementary: supplementary)

      if style == 'visual'
        # image_file = openai_api.generate_images(self.content)
        # styled_lesson.images.attach(io: image_file, filename: "#{self.title.parameterize}-#{style}.jpg") if image_file.present?
      elsif style == 'aural'
        audio_file = @openai_api.generate_audio(self.content)
        styled_lesson.files.attach(io: StringIO.new(audio_file), filename: "#{self.title.parameterize}-#{style}.mp3")
      elsif style == 'reading'
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
        styled_lesson.content = markdown.render(self.content)
        styled_lesson.save
      elsif style == 'kinesthetic'
        generated_content = openai_api.generate_content(self.content, style: style)
        styled_lesson.content = generated_content
        styled_lesson.save
      end
    end
  end
end
