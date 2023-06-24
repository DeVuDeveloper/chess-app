class ChatsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!

  def index
    @chats = Chat.ordered.includes(:messages)
  end

  def new
    @chat = Chat.new
    @chats = Chat.all
  end

  def create
    @chat = Chat.new(user_id: current_user.id)
    @chats = Chat.ordered.includes(:messages)
    
  
    if @chat.save
      @chats = Chat.all # Assign @chats to fetch all chats after the new chat is created
      respond_to do |format|
        format.html { redirect_to chat_path(@chat), notice: "Chat was successfully created." }
        format.turbo_stream
      end
  end
end
  
def update
  @chat = Chat.find(params[:id])
  # Update chat logic here

  respond_to do |format|
    format.turbo_stream { render turbo_stream: turbo_stream.replace(@chat) }
    format.html { redirect_to chats_path }
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
