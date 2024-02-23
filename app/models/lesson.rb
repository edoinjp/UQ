class Lesson < ApplicationRecord
  belongs_to :classroom
  has_many :questions, dependent: :destroy
  has_many :styled_lessons, dependent: :destroy
  after_create :create_styled_lessons

  private

  def create_styled_lessons
    styles = %w[aural kinesthetic reading visual]
    styles.each do |style|
      styled_lessons.create(style: style)
    end
  end
end
