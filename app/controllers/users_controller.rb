class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  after_action :verify_authorized

  def show
    authorize @user
    if @user.teacher?
      @classroom = @user.classrooms.first
    else
      @classroom = @user.participations.first&.classroom
    end
    @lessons&.lessons&.first
    @quiz_score = @lesson ? rand(1..5) : 'N/A'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
