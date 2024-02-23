# ChatroomsController
class ChatroomsController < ApplicationController
  def show
    skip_authorization
    @chatroom = Chatroom.find(params[:id])
    @classroom = current_user.classrooms.find_by(id: @chatroom.classroom_id)
    if @classroom
      @students = @classroom.students
    else
      puts "No associated classroom found for the chatroom."
    end
    @message = Message.new
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

end
