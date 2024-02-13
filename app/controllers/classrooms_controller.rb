class ClassroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    Rails.logger.debug("Current User: #{current_user.inspect}")
    authorize Classroom
    @classrooms = policy_scope(Classroom)
  end

  def show
    @classroom = find_classroom
    @participants = @classroom.students
  end

  def new
    authorize Classroom
    @classroom = Classroom.new

  end

  def create
    authorize Classroom
    @classroom = current_user.classrooms.build(classroom_params)

    if @classroom.save
      redirect_to classrooms_path, notice: 'Classroom was successfully created.'
    else
      render :new
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name) # Add other attributes as needed
  end

  def find_classroom
    Classroom.find(params[:id])
  end
end
