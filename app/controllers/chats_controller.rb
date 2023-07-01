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
        format.html { redirect_to chat_path(@chat.id), notice: "Chat was successfully created." }
        format.turbo_stream
      end
    end
  end

  def destroy
    @chat = Chat.find_by(id: params[:id])

    if @chat
      @chat.destroy
      respond_to do |format|
        format.html { redirect_to chats_path, notice: "Chat was successfully destroyed." }
        format.turbo_stream
      end
    else
      redirect_to chats_path, alert: "Chat not found."
    end
  end
end
