# ChatroomsController
class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  def create
    skip_authorization
    @other_user = User.find(params[:user_id])
    @chatroom = Chatroom.joins(:users).where(users: [@other_user, current_user]).group(:id).having("COUNT(users.id) = 2").first

    if @chatroom.nil?
      @classroom = Classroom.find(chatroom_params[:classroom_id])
      @chatroom = Chatroom.create(name: "#{@other_user.full_name}-#{current_user.full_name}", classroom: @classroom )
      ChatroomUser.create(user: current_user, chatroom: @chatroom)
      ChatroomUser.create(user: @other_user, chatroom: @chatroom)
    end
    redirect_to chatroom_path(@chatroom)
  end



  def show
    skip_authorization
    @active_tab = "chatroom"
    @chatroom = Chatroom.find(params[:id])
    if current_user.teacher?
      @classroom = current_user.classrooms.find_by(id: @chatroom.classroom_id)
    else
      @classroom = current_user.participations.first.classroom
    end
    if @classroom
      @teacher = @classroom.user
      @students = @classroom.students
      @responses = Response.where(lesson_id: @classroom.lessons.pluck(:id))
    else
      puts "No associated classroom found for the chatroom."
    end
    @message = Message.new
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end
  def chatroom_params
    params.require(:chatroom).permit(:classroom_id)
  end
end
