class ResponseController < ApplicationController
  before_action :set_lesson, only: :index

  def index
    # Only Teachers can access this page
    authorize @lesson, policy_class: ResponsePolicy

    # Code based on 1 Qs has correct choice and student can answer once
    @student_responses = @lesson.questions.inculdes(choices: :responses).map do |question|
      questions.choices.map do |choice|
        choice.responses.map do |response|
          { student: response.user, question: question, correct: choice.correct }
        end
      end
    end.flatten.group_by { |response| response[:student] }

    # Fake scores for demo
    @student_responses.transform_values! do |responses|
      correct_answers = responses.count { |response| response[:correct] }
      { correct_count: correct_answers, total_questions: @lesson.questions.count }
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
