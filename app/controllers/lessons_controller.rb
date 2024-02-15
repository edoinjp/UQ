class LessonsController < ApplicationController
  before_action :authenticate_user!, :set_lesson, only: %i[show]

  def index
    @lessons = policy_scope(Lesson)
  end

  # Authorizes show action through current lesson through prarams
  def show
    authorize(@lesson)
    # Assigns a variable for each styled_lesson style type
    @visual = @lesson.styled_lessons.find { |x| x['style'] == 'visual' }
    @aural = @lesson.styled_lessons.find { |x| x['style'] == 'aural' }
    @reading = @lesson.styled_lessons.find { |x| x['style'] == 'reading' }
    @kinesthetic = @lesson.styled_lessons.find { |x| x['style'] == 'kinesthetic' }
  end

  private

  # Use callbacks to share common setup or contraints between actions
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  # Strong params to help create new lessons
  def lesson_params
    params.require(:lesson).permit(:title, :file)
  end
end
