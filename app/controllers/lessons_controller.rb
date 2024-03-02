class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classroom, only: [:index, :new, :create]
  before_action :set_lesson, only: [:show]
  include ActionController::Live # Allows AI chat streaming

  def index
    @lessons = policy_scope(Lesson)
    @classroom = Classroom.find(params[:classroom_id])
    @lessons = @classroom.lessons
    @classrooms = [@classroom]
    @active_tab = "classroom_lessons"
  end

  # Authorizes show action through current lesson through prarams
  def show
    @active_tab = "classroom_lessons"
    @classroom = @lesson.classroom

    authorize(@lesson)
    # Assigns a variable for each styled_lesson style type
    @visual = @lesson.styled_lessons.find { |x| x['style'] == 'visual' }
    @aural = @lesson.styled_lessons.find { |x| x['style'] == 'aural' }
    @reading = @lesson.styled_lessons.find { |x| x['style'] == 'reading' }
    @kinesthetic = @lesson.styled_lessons.find { |x| x['style'] == 'kinesthetic' }

    # Logic to have student avatars appear according the the lesson style
    @students = @classroom.students
    if params[:query].present?
      @students = @students.where(learning_style: params[:query])
    end

    # AI Chat Helper Code
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate # Helps prevent bug from streaming output
    sse = SSE.new(response.stream, event: 'message') # Variable for Server Sent Event
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])

    begin
      client.chat( # Calls the chat API
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [{ role: 'user', content: params[:prompt] }], # Prompt to pass as a query parameter
          stream: proc do |chunk| # Creates a procedure to handle incoming steam from API
            content = chunk.dig('choices', 0, 'delta', 'content') # Fetches content from API response
            if content.nil? # Return from procedure once theres no more content
              return
            end
            sse.write({ message: content }) # Writes the response to the message event
          end
        }
      )
    ensure
      if !sse.closed?
        sse.close # Makes sure it closes
      end
    end


    # Creates quiz scores for each seeded lesson
    @lessons_with_scores = [@classroom].map(&:lessons).flatten.map do |lesson|
      {lesson: lesson, quiz_score: rand(0..5)}
    end

    # Creates additional lessons on top of the seeded ones
    additional_lesson_titles = ["Oral Communication II", "Social Science", "Language Arts"]
    additional_lesson_titles.each do |title|
      @lessons_with_scores << { lesson: OpenStruct.new(title: title), quiz_score: rand(0..5) }
    end

    # Creates the individual student progress charts in the pop-up
    @chart_data = {}
    @lessons_with_scores.each do |lesson_result|
      @chart_data[lesson_result[:lesson].title] = lesson_result[:quiz_score]
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
    @lesson = Lesson.new(lesson_params)
    @classroom = Classroom.find(params[:classroom_id])
    @lesson.classroom = @classroom
    authorize(@lesson)

    if @lesson.save
      @lesson.create_styled_lessons
      redirect_to classroom_lessons_path(@lesson.classroom, @lesson), notice: 'Lesson was successfully created.'
    else
      render :new
    end
  end

  def download_pdf
    @lesson = Lesson.find(params[:id])
    authorize @lesson

    # respond_to do |format|
    #   format.html {
    #   }
    #   format.pdf do
    #     render pdf: "lesson_content",
    #     partial: "lessons/reading_content",
    #     locals: { reading: @reading },
    #     layout: false
    #   end
    file = Tempfile.new(["pdf file", ".pdf"])
    file.write(pdf_as_string)
    file.rewind
    f = File.new("text.pdf", "w")
    f.write(pdf_as_string)
    f.rewind
    render(
      pdf: "lesson_content",
      locals: { reading: @lesson },
      template: "lessons/_reading_content",
      # layout: "pdf.html",
      disposition: "attachment",
      format: "html"
      )
  end

  private

  # Use callbacks to share common setup or contraints between actions
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  # Strong params to help create new lessons
  def lesson_params
    params.require(:lesson).permit(:title, :content)
  end

  def set_classroom
    begin
      @classroom = Classroom.find(params[:classroom_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Classroom not found.'
      redirect_to classrooms_path
    end
  end

  def openai_api
    @openai_api ||= OpenaiApi.new
  end

  def pdf_as_string
    render_to_string partial: "lessons/reading_content", layout: false, locals: { reading: @lesson }, formats: :html
  end
end
