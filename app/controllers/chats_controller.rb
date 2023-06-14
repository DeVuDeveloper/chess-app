class ChatsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chat, only: [:show, :edit, :update, :destroy]
    respond_to :html, :json

    def index
      @chats = Chat.ordered
    end
  
    def show
      respond_with(@chat)
    end

    def def new
      @chat = Chat.new
    end
    
    def create
      @chat = Chat.create(user: current_user)
      respond_to do |format|
        format.html { redirect_to chat_path(@chat), notice: "Chat was successfully created." }
        format.turbo_stream
      end
    end

    def destroy
      @chat.destroy
      respond_to do |format|
        format.html { redirect_to chats_path, notice: "Chat was successfully destroyed." }
        format.turbo_stream
      end
    end
  
    private
  
    def set_chat
      @chat = Chat.find(params[:id])
    end
end
