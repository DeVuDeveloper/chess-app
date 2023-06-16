class MessagesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!

  def create
    @message = Message.create(content: message_params[:content], chat_id: message_params[:chat_id], role: "user")
  
    GetAiResponseJob.perform_async(@message.chat_id)
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("#{dom_id(@message.chat)}_messages", partial: "messages/_message", locals: { message: @message, scroll_to: true }),
               turbo_stream: turbo_stream.replace("#{dom_id(@message.chat)}_message_form", partial: "messages/_form", locals: { chat: @message.chat })
      end
      format.html { redirect_to chat_path(params[:chat_id]) }
    end
  end
  

  private

  def message_params
    params.require(:message).permit(:content, :chat_id)
  end
end

