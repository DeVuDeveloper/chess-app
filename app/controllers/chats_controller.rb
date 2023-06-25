class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_chat, only: [:edit, :update, :destroy]

  def index
    @chats = @user.chats.ordered
    @chat = @chats.first
  end

  def new
    @chat = @user.chats.build
  end

  def create
    @chat = @user.chats.build(user_id: @user.id)

    if @chat.save
      respond_to do |format|
        format.html { redirect_to user_chats_path(@user), notice: "Chat was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Chat was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
 
  end

  def update
   

    if @chat.update(user_id: @user.id)
      respond_to do |format|
        format.html { redirect_to user_path(@user), notice: "Chat was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Chat was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "Chat was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Chat was successfully destroyed." }
    end
  end

  private

  def set_chat
    @chat = @user.chats.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:user_id)
  end

  def set_user
    @user = current_user
  end
end
