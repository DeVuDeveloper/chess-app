class MessagesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.create(message_params.merge(chat_id: @chat.id, role: "user"))
  
    GetAiResponseJob.perform_async(@message.chat_id)
  
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.append(@message, target: "#{dom_id(@chat)}_messages") }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
