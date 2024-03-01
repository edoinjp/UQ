class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  after_action :verify_authorized

  def show
    @active_tab = "students"
    authorize @user

    # Get the user's classrooms
    @classrooms = @user.student? ? @user.participations.map(&:classroom) : @user.classrooms

    # Choose the first classroom from the list / this logic is not correct because : =>
    # its getting first classroom currently this is only way to display sidebar on users show page
    # @classroom = @classrooms.first if @classrooms.present?

    # Initialize an empty hash to store lesson scores for the user
    @lessons_with_scores = {}

    # Iterate over each classroom and its lessons to calculate the correct count
    @classrooms.each do |classroom|
      classroom.lessons.each do |lesson|
        # Assuming each lesson has a score associated with it
        lesson_score = lesson.scores.find_by(user_id: @user.id)
        if lesson_score.present?
          @lessons_with_scores[lesson] = {
            correct_count: lesson_score.correct_count, # Assuming 'correct_count' is the attribute for correct answers
            total_questions: lesson.questions.count
          }
        else
          # Handle the case where the user hasn't attempted the lesson
          @lessons_with_scores[lesson] = {
            correct_count: 0,
            total_questions: lesson.questions.count
          }
        end
      end
    end

    # Chartkick setup for the chart display logic
    @chart_data = {}
    @lessons_with_scores.each do |lesson_result|
      @chart_data[lesson_result[:lesson].title] = lesson_result[:quiz_score]
    end

  end

  def test
    @user = User.new
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
