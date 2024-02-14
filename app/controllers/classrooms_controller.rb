class ClassroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_classroom, only: [:show]
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :add_students]

  def index
    Rails.logger.debug("Current User: #{current_user.inspect}")
  authorize Classroom
  @classrooms = policy_scope(Classroom)
  end

  def show
    authorize @classroom
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
      Rails.logger.error("Classroom creation failed: Errors - #{ @classroom.errors.full_messages }")
      render :new
    end
  end

  def add_students
    set_classroom
    # Authorize using the instance of @classroom and the action :add_students?
    authorize @classroom, :add_students?
    selected_student_ids = params.dig(:classroom, :student_ids) || []
    @classroom.students << User.find(selected_student_ids)

    redirect_to @classroom, notice: "Students added successfully."
  end



  private
  def set_classroom
    @classroom = Classroom.find_by(id: params[:id])

    unless @classroom
      flash[:alert] = 'Classroom not found.'
      redirect_to classrooms_path
    end
  end

  def classroom_params
    params.require(:classroom).permit(:name, :title)
  end

  def find_classroom
    @classroom = Classroom.find_by(id: params[:id])

    unless @classroom
      flash[:alert] = 'Classroom not found.'
      redirect_to classrooms_path
    end
  end

end
