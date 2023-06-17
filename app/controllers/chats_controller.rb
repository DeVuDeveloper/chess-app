class ChatsController < ApplicationController
  before_action :authenticate_user!
 

  def index
    @chats = Chat.ordered
    @chat = @chats.first
  end


   def show
    @chat = Chat.find(params[:id])
   end

   def new
    @chat = Chat.new
   end


  def create
    @chat = Chat.new(user_id: current_user.id)
    if @chat.save
      redirect_to chats_path
    else
      @chats = current_user.chats
      render :index
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to chats_url, notice: "Chat was successfully deleted."
  end
  private

  def chat_params
    params.require(:chat).permit(:user_id)
  end
end


class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(user_id: current_user.id)
    if @chat.save
      redirect_to chats_path
    else
      @chats = current_user.chats
      render :index
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to chats_path
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id)
  end
end

