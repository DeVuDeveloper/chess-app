class ImagesController < ApplicationController
    before_action :set_image, only: [:show, :edit, :update, :destroy]

    def show
        @image = Image.find(params[:id])
      end
    
    def new
      @image = Image.new
    end
  
    def create
      @image = Image.new(image_params)
  
      if @image.save
        generate_image
        respond_to do |format|
            format.html { redirect_to game_path(@game), notice: "Game was successfully created." }
            format.turbo_stream
    end
  end
end
  
    def destroy
        @image.destroy
        respond_to do |format|
          format.html { redirect_to messages_path, notice: "Image was successfully destroyed." }
          format.turbo_stream
        end
      end

    def update
        if @image.update(image_params)
          redirect_to messages_path, notice: "Image was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
    end
  
    private

    def set_image
        @image = Image.find(params[:id])
      end
  
    def image_params
      params.require(:image).permit(:prompt, :size)
    end
  
    def generate_image
      openai_client = OpenAI::Client.new(access_token: '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')
    
      response = openai_client.images.generate(
        parameters: {
          prompt: @image.prompt,
          size: @image.size
        }
      )
    
      if response.key?("data")
        @image.url = response.dig("data", 0, "url")
        @image.save
      else
        flash[:alert] = 'Failed to generate image.'
      end
    end
  end
  