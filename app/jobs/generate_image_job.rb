class GenerateImageJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    
    # Generišite sliku na osnovu poruke
    image_url = generate_image(message.content)
    
    if image_url.present?
      # Sačuvaj URL slike u Image modelu
      image = Image.new(url: image_url, message: message)
      image.save
    end
  end

  private

  def generate_image(content)
    # Implementirajte logiku za generisanje slike na osnovu sadržaja (content) poruke
    # Ovde možete koristiti OpenAI API ili druge alate/biblioteke za generisanje slika
    
    # Primer: Generisanje URL-a slike pomoću OpenAI API-ja
    openai_client = OpenAI::Client.new(access_token: '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')
    response = openai_client.images.generate(parameters: { prompt: content, size: '256x256' })
    image_url = response.dig('data', 0, 'url')
    
    image_url
  end
end
