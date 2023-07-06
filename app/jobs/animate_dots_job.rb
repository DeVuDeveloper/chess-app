class AnimateDotsJob < ApplicationJob
    queue_as :default
  
    def perform(message_id)
      message = Message.find_by(id: message_id)
      return unless message.present?
  
      loop do
        message.update(content: "#{message.content}.")
  
        # Zaustavljamo dodavanje tačaka ako je poruka ažurirana sa finalnim odgovorom
        break if message.reload.content != "Waiting for response..."
  
        sleep 1 # Pauza između dodavanja tačaka
      end
    end
  end
  