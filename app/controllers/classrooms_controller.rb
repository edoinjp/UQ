class ClassroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize Classroom
    @classrooms = policy_scope(Classroom)
  end

  def new
    @classroom = Classroom.new
  end

  def show
    @classroom = Classroom.find(params[:id])
    @participants = @classroom.students
  end


  def create
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
end
