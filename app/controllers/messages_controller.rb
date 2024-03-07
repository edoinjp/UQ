# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  def create
    skip_authorization
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user

    if params[:direct_message]
      recipient = User.find(params[:direct_message][:recipient_id])
      @direct_message = current_user.sent_direct_messages.build(content: params[:message][:content], recipient: recipient)

      if @direct_message.save
        DirectMessageChannel.broadcast_to(
          recipient,
          render_to_string(partial: "direct_messages/direct_message", locals: { direct_message: @direct_message })
        )
        head :ok
      else
        render "direct_messages/show", status: :unprocessable_entity
      end
    else
      if @message.save
        ChatroomChannel.broadcast_to(
          @chatroom,
          {
            user_id: current_user.id,
            message: render_to_string(partial: "messages/message", locals: { message: @message })
          }

        )
        head :ok
      else
        render "messages/show", status: :unprocessable_entity
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
