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

  def test
    @user = User.new
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
