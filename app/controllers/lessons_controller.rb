class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classroom, only: [:index]
  before_action :set_lesson, only: [:show]

  def index
    @lessons = policy_scope(Lesson)
    @classroom = Classroom.find(params[:classroom_id])
    @lessons = @classroom.lessons
    @classrooms = [@classroom]

    @lessons_with_scores = @classrooms.map(&:lessons).flatten.map do |lesson|
      {lesson: lesson, quiz_score: rand(0..5)}
    end

    additional_lesson_titles = ["Oral Communication II", "Social Science", "Language Arts"]
    additional_lesson_titles.each do |title|
      @lessons_with_scores << { lesson: OpenStruct.new(title: title), quiz_score: rand(0..5) }
    end


    @chart_data = {}
    @lessons_with_scores.each do |lesson_result|
      @chart_data[lesson_result[:lesson].title] = lesson_result[:quiz_score]
    end




  end

  # Authorizes show action through current lesson through prarams
  def show
    @classroom = @lesson.classroom

    authorize(@lesson)
    # Assigns a variable for each styled_lesson style type
    @visual = @lesson.styled_lessons.find { |x| x['style'] == 'visual' }
    @aural = @lesson.styled_lessons.find { |x| x['style'] == 'aural' }
    @reading = @lesson.styled_lessons.find { |x| x['style'] == 'reading' }
    @kinesthetic = @lesson.styled_lessons.find { |x| x['style'] == 'kinesthetic' }

    @students = @classroom.students
    if params[:query].present?
      @students = @students.where(learning_style: params[:query])
    end
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

  def set_classroom
    begin
      @classroom = Classroom.find(params[:classroom_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Classroom not found.'
      redirect_to classrooms_path
    end
  end
end
