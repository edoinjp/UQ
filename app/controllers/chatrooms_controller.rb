# ChatroomsController
class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]

  def show
    skip_authorization
    @active_tab = "chatroom"
    @chatroom = Chatroom.find(params[:id])
    @classroom = current_user.classrooms.find_by(id: @chatroom.classroom_id)
    if @classroom
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
end
