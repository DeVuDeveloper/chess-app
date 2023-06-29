class MessagesController < ApplicationController


  def index
    @message = Message.new
    @chats = Chat.all
    @chat_id = params[:chat_id] if params[:chat_id].present?
  
    # Add this code to filter messages for the selected chat
    if @chat_id.present?
      @messages = Message.where(chat_id: @chat_id)
    else
      @messages = []
    end
  end

  def new_chat
    @chat = Chat.new
    session[:chat_id] = @chat.id
  
    respond_to do |format|
      format.html { redirect_to messages_path(chat_id: @chat.id) }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("message-list", "") }
    end
  end


  def create
    if params[:new_chat].present?
      new_chat
    else
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
  end



  private

  def message_params
    params.require(:message).permit(:content, :user_id, :chat_id)
  end
end
