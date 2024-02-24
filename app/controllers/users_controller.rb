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
