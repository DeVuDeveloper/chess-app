class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = Chat.all
    @chat = Chat.new
  end

  def new
    @chat = Chat.new
    @chats = Chat.all
  end

  def create
    @chat = Chat.new(user_id: current_user.id)

    if @chat.save
      respond_to do |format|
        format.html { redirect_to chat_path(@chat), notice: "Chat was successfully created." }
        format.turbo_stream
      end
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    respond_to do |format|
      format.html { redirect_to chats_path, notice: "Chat was successfully destroyed." }
      format.turbo_stream 
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id)
  end
end

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @chats = Chat.all.order(created_at: :desc)

    @message = Message.new
    
    if params[:chat_id].present?
      @chat = Chat.find_by(id: params[:chat_id])
      @messages = @chat ? @chat.messages.order(created_at: :asc) : []
    else
      @chat = nil
      @messages = []
    end
  end

  # Ostatak kontrolera...
end
