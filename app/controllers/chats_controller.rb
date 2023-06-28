# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  def index
    @chats = Chat.includes(:messages).all
    @new_message = Message.new
  end

  def create
    @new_chat = Chat.new(chat_params)
    if @new_chat.save
      @new_chat.messages.create(content: "Welcome to the chat!")
      respond_to do |format|
        format.js { render js: "window.location.reload();" }
      end
    else
      # Handle the case when chat creation fails
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:name, )
  end
end
