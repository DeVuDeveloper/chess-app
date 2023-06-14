class ChatsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chat, only: %i[show]
    respond_to :html, :json

  
  
    def show
      respond_with(@chat)
    end

    def def new
      @chat = Chat.new
    end
    
  
    def create
      @chat = Chat.create(user: current_user)
      respond_with(@chat)
    end
  
    private
  
    def set_chat
      @chat = Chat.find(params[:id])
    end
end
