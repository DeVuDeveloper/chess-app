class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @message = Message.new
    @chat = Chat.new
    @chats = Chat.all
    @chat_id = params[:chat_id] if params[:chat_id].present?
  end

  def create
    @message = current_user.messages.new(message_params)
  
    if session[:chat_id].nil?
      @chat = Chat.create(name: @message.content[0, 10])
      session[:chat_id] = @chat.id
    else
      @chat = Chat.find_by(id: session[:chat_id])
      @chat ||= Chat.create(name: @message.content[0, 10])
      session[:chat_id] = @chat.id
    end
  
    @message.chat_id = @chat.id
  
    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: "Message was successfully created." }
        format.turbo_stream
      else
        format.html { redirect_to messages_path, alert: "Message could not be created." }
      end
    end
  end
  
  
  

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :chat_id)
  end
  
end
