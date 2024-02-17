class ClassroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_classroom, only: [:show]
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :add_students]

  def index
    session[:return_to] = request.fullpath
    @classrooms = policy_scope(Classroom)
    @active_tab = "classrooms"

  end

  def show
    set_classroom
    authorize @classroom
    @participants = @classroom.students
    @controller_name = controller_name
    @action_name = action_name
    @active_tab = "students"
    @classrooms = [@classroom]  # Ensure that @classrooms is set for the sidebar

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
    @classroom = Classroom.find_by(id: params[:id])
    # Authorize using the instance of @classroom and the action :add_students?
    authorize @classroom, :add_students?
    selected_student_ids = params.dig(:classroom, :student_ids) || []
    @classroom.students << User.find(selected_student_ids)

    redirect_to @classroom, notice: "Students added successfully."
  end



  private
  def set_classroom
    puts "Parameters in set_classroom: #{params.inspect}"
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
