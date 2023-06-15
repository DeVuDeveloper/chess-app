class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:edit, :update, :destroy]
  respond_to :html, :json

  def index
    @chats = Chat.ordered
    @chats.each do |chat|
      @chat = chat
    end
  end


  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.create(user: current_user)
    if @chat.save
      @chat.broadcast_prepend_to("chats", partial: "chats/chat_details", locals: { chat: @chat }, target: "chat-details")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chats_path }
      end
    else
      render :new
    end
  end

  def destroy
    if @chat.destroy
 
    respond_to do |format|
      format.html { redirect_to chats_path, notice: "Chat was successfully destroyed." }
      format.turbo_stream
    end
  end
end
  private

  def set_chat
    @chat = Chat.find(params[:id])
  end
end

