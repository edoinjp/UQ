class ResponsesController < ApplicationController
  before_action :set_lesson, only: :index

  def index
    @active_tab = "responses"
    @classroom = @lesson.classroom
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
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
