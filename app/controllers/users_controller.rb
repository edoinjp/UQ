class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  after_action :verify_authorized

  def show
    authorize @user
    @classroom = @user.classrooms_as_student.first
    @lessons = @classroom ? @classroom.lessons.first : nil
    @quiz_score = @lesson ? rand(1..5) : 'N/A'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
