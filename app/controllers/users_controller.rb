class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  after_action :verify_authorized

  def show
    authorize @user
    # Get the user's classroom and lessons
    @classrooms = @user.student? ? @user.participations.map(&:classroom) : @user.classrooms
    @lessons_with_scores = @classrooms.map(&:lessons).flatten.map do |lesson|
      {lesson: lesson, quiz_score: rand(0..5)}
    end

    additional_lesson_titles = ["Oral Communication II", "Social Science", "Language Arts"]
    additional_lesson_titles.each do |title|
      @lessons_with_scores << { lesson: OpenStruct.new(title: title), quiz_score: rand(0..5) }
    end

    # Chartkick setup for the chart display logic
    @chart_data = {}
    @lessons_with_scores.each do |lesson_result|
      @chart_data[lesson_result[:lesson].title] = lesson_result[:quiz_score]
    end

  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
