class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classroom, only: [:index, :new, :create]
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

  def new
    @classroom = Classroom.find(params[:classroom_id])
    @lesson = @classroom.lessons.new
    authorize(@lesson)
  end


  def create
    @lesson = @classroom.lessons.new(lesson_params)
    authorize(@lesson)

    if @lesson.save
      redirect_to classroom_lessons_path(@lesson.classroom, @lesson), notice: 'Lesson was successfully created.'
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
    params.require(:lesson).permit(:title, :file, :picture)
  end

  def set_classroom
    begin
      @classroom = Classroom.find(params[:classroom_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Classroom not found.'
      redirect_to classrooms_path
    end
  end

  def create_styled_lessons(lesson)
    styles = ['visual', 'aural', 'reading', 'kinesthetic']
    styles.each do |style|
      styled_lesson = styled_lessons.create(style: style)
      if style == 'visual'
        image_content = generate_images.generate_images(lesson.title)
      elsif style == 'aural'
        audio_content = generate_audio.generate_audio(lesson.title)
      elsif style == 'reading'
        reading_content = generate_reading.generate_reading(lesson.title)
      elsif style == 'kinesthetic'
        kinesthetic_content = generate_kinesthetic.generate_kinesthetic(lesson.title)
      end
    end
  end

  def openai_api
    @openai_api ||= OpenaiApi.new
  end
end
