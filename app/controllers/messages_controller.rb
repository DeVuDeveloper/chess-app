class MessagesController < ApplicationController
  before_action :set_user, only: [:new, :create]
  before_action :set_chat
  before_action :set_message, only: [:edit, :update, :destroy]

  def new
    @message = @chat.messages.build
  end

  def create
    @message = @chat.messages.build(message_params.merge(chat_id: params[:chat_id], role: "user"))
    GetAiResponseJob.perform_async(@message.chat_id)

    if @message.save
      respond_to do |format|
        format.html { redirect_to user_path(@user), notice: "Message was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Message was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
      if @message.update(message_params)
        respond_to do |format|
          format.html { redirect_to user_path(@user), notice: "Message was successfully updated." }
          format.turbo_stream { flash.now[:notice] = "Message was successfully updated." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @message.destroy
    
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "Chat was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Chat was successfully destroyed." }
    end
  end

  private

  def set_message
    @message = @chat.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def set_user
    @user = current_user
  end

  def set_chat
    @chat = @user.chats.find(params[:chat_id])
  end
end