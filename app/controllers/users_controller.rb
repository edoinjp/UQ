class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  after_action :verify_authorized

  def show
    authorize @user
    @lessons = @user.classrooms.first.lessons.first
    @quiz_score = rand(1..5)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
