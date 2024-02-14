class LessonsController < ApplicationController
  before_action :authenticate_user!, :set_lesson, only: %i[show]
  after_action :verify_authorized

  def index
    @lessons = policy_scope(Lesson)
  end

  # Authorizes show action through current lesson through prarams
  def show
    authorize(@lesson)
  end

  private

  # Use callbacks to share common setup or contraints between actions
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

end
