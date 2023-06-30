class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = Message.new
    @chats = Chat.all.order(created_at: :desc)
  
    if session[:chat_id].present?
      @chat = Chat.find_by(id: session[:chat_id])
      @messages = @chat ? @chat.messages : []
    else
      @chat = nil
      @messages = []
    end
  end
  
  def create
    if params[:new_chat].present?
      initialize_chat
    else
      @message = Message.new(role: "user", content: message_params[:content])
  
      if session[:chat_id].nil?
        initialize_chat
      else
        @chat = Chat.find_by(id: session[:chat_id]) || current_user.chats.create!
        session[:chat_id] = @chat.id
      end
  
      @message.chat_id = @chat.id
      @message.role = "user"
  
      # Update the chat name based on the latest message content
      @chat.update(name: @message.content&.slice(0, 10))
  
      respond_to do |format|
        if @message.save
          GetAiResponseJob.perform_async(@message.chat_id)
          format.html { redirect_to messages_path, notice: "Message was successfully created." }
          format.turbo_stream
        else
          format.html { redirect_to messages_path, alert: "Message could not be created." }
        end
      end
    end
  end

  def new_chat
    initialize_chat
  
    respond_to do |format|
      format.html { redirect_to messages_path(chat_id: @chat.id) }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("message-list", "") }
    end
  end

  private

  def initialize_chat
    @chat = Chat.create!(user_id: current_user.id)
    session[:chat_id] = @chat.id
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
