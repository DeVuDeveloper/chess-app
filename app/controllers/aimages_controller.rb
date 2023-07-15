class AimagesController < ApplicationController
    before_action :set_aimage, only: [:edit, :update, :destroy]

    def new
      @aimage = Aimage.new
    end
  
    def create
      @aimage = Aimage.new(aimage_params)
  
      if @aimage.save
        generate_aimage
        respond_to do |format|
            format.html { redirect_to aimage_path(@aimage), notice: "Aimage was successfully created." }
            format.turbo_stream
    end
  end
end
  
    def destroy
        @aimage.destroy
        respond_to do |format|
          format.html { redirect_to messages_path, notice: "aimage was successfully destroyed." }
          format.turbo_stream
        end
      end

    def update
        if @aimage.update(aimage_params)
          redirect_to messages_path, notice: "aimage was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
    end
  
    private

    def set_aimage
        @aimage = Aimage.find(params[:id])
      end
  
    def aimage_params
      params.require(:aimage).permit(:prompt, :size)
    end
  
    def generate_aimage
      openai_client = OpenAI::Client.new(access_token: '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')
    
      response = openai_client.images.generate(
        parameters: {
          prompt: @aimage.prompt,
          size: @aimage.size
        }
      )
    
      if response.key?("data")
        @aimage.url = response.dig("data", 0, "url")
        @aimage.save
      else
        flash[:alert] = 'Failed to generate aimage.'
      end
    end
  end
  