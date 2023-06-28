class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  def index
    @chats = Chat.ordered
  end

  def show
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.create!(chat_params)

    if @chat.save
      respond_to do |format|
        format.html { redirect_to messages_path, notice: "Chat was successfully created." }
        format.turbo_stream
      end
    end
  end

  def edit
  end

  def update
    if @chat.update(chat_params)
      redirect_to messages_path, notice: "chat was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chat.destroy
    respond_to do |format|
      format.html { redirect_to messages_path, notice: "Chat was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:name, :user_id)
  end
end