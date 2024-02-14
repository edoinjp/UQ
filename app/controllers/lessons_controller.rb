class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[index show]
  after_action :verify_authorized

  def index
    @lessons = policy_scope(Lesson)
  end

  private

  def set_user
    @user = User.first
  end

end
