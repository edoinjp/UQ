class ResponsesController < ApplicationController
  before_action :set_lesson, only: :index

  def index
    # to dsiplay it on side bar
    @active_tab = "responses"
    # Only Teachers can access this page
    #  Gather all responses
    @responses = policy_scope(Response)
    # @responses = policy_scope(Response.includes(:choice).where(choices: { question_id: @lesson.questions.ids }))

    # get all studnets who participated in the lesson
    student_ids = @lesson.classroom.students.pluck(:id)

    # For each student, generate a fake score
    @student_scores = User.where(id: student_ids).each_with_object({}) do |student, scores|
      scores[student] = {
        correct_count: rand(1..@lesson.questions.count), # Random correct answers
        total_questions: @lesson.questions.count # Total questions for the lesson
      }

    @lessons_with_scores = [@lesson.classroom].map(&:lessons).flatten.map do |lesson|
      {lesson: lesson, quiz_score: rand(0..5)}
    end

    additional_lesson_titles = ['Oral Communication II', 'Social Science', 'Language Arts']
    additional_lesson_titles.each do |title|
      @lessons_with_scores << { lesson: OpenStruct.new(title: title), quiz_score: rand(0..5) }
    end

    @chart_data_all = [
      {name: 'Visual', data: {'Ice Breakers': rand(0..5), 'Oral Communication II': rand(0..5), 'Social Science': rand(0..5), 'Language Arts': rand(0..5)}},
      {name: 'Aural', data: {'Ice Breakers': rand(0..5), 'Oral Communication II': rand(0..5), 'Social Science': rand(0..5), 'Language Arts': rand(0..5)}},
      {name: 'Reading', data: {'Ice Breakers': rand(0..5), 'Oral Communication II': rand(0..5), 'Social Science': rand(0..5), 'Language Arts': rand(0..5)}},
      {name: 'Kinesthetic', data: {'Ice Breakers': rand(0..5), 'Oral Communication II': rand(0..5), 'Social Science': rand(0..5), 'Language Arts': rand(0..5)}}
    ]
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
