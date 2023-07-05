class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = Chat.all.order(created_at: :desc)
    @message = Message.new
    @messages = Message.where(chat_id: params[:chat_id]).order(created_at: :asc)
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
  
      @chat.update(name: @message.content&.slice(0, 10))
  
       
          if @message.save
            GetAiResponseJob.perform_async(@message.chat_id)
         

            respond_to do |format|
              format.html { redirect_to message_path(@message), notice: "message was successfully created." }
              format.turbo_stream
            end
          end
    end
  end

  def new_chat
    initialize_chat
  
    respond_to do |format|
      format.html { redirect_to messages_path(chat_id: @chat.id) }
      format.turbo_stream
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