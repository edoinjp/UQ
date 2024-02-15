class ResponsesController < ApplicationController
  before_action :set_lesson, only: :index

  def index
    # Only Teachers can access this page
    authorize @lesson, policy_class: ResponsePolicy

    #  Gather all responses
    @responses = Response.includes(choice: { question: :lesson }).where(choices: { questions: { lesson: @lesson } })

    # Fake scores for demo
    @student_scores = @responses.group_by(&:user).transform_values do |responses|
      correct_count = responses.select { |response| response.choice.correct }.size
      { correct_count: correct_count, total_questions: @lesson.questions.count }
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
