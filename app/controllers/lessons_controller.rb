class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classroom, only: [:index]
  before_action :set_lesson, only: [:show]

  def index
    @lessons = policy_scope(Lesson)
    @classroom = Classroom.find(params[:classroom_id])
    @lessons = @classroom.lessons
    @classrooms = [@classroom]
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
    # @openai_api = OpenaiApi.new
    # @paragraph = @openai_api.generate_content(@lesson.title)
  end

  def def new
    @classroom = Classroom.find(params[:classroom_id])
    @lesson = @classon.lessons.new
    authorize(@lesson)
  end


  def create
    @lesson = @classroom.lessons.new(lesson_params)
    authorize(@lesson)

    if @lesson.save
      generate_content_for_lesson(@lesson)
      redirect_to classroom_lesson_path(@lesson.classroom, @lesson), notice: 'Lesson was successfully created.'
    else
      render :new
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

  def generate_content_for_lesson(lesson)
    openai_api = OpenaiApi.new
    paragraph = openai_api.generate_content(lesson.title)
    lesson.update(content: paragraph)
  end
end
