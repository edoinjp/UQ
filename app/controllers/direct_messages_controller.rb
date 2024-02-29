class DirectMessagesController < ApplicationController
  def create
    recipient = User.find(params[:recipient_id])
    @direct_message = current_user.sent_direct_messages.build(content: params[:content], recipient: recipient)

    if @direct_message.save
      DirectMessageChannel.broadcast_to(
        recipient,
        render_to_string(partial: "direct_messages/direct_message", locals: { direct_message: @direct_message })
      )
      head :ok
    else
      render json: { error: @direct_message.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
