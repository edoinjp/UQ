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

    additional_lesson_titles = ["Fake Lesson 1", "Fake Lesson 2", "Fake Lesson 3"]
    additional_lesson_titles.each do |title|
      @lessons_with_scores << { lesson: OpenStruct.new(title: title), quiz_score: rand(0..5) }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
