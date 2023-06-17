require 'sidekiq'

class GetAiResponseJob < SidekiqJob

  def perform(chat_id)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)
    message = chat.messages.create(role: "assistant", content: "Waiting for response...")
    message.broadcast_created
  
    openai_client = OpenAI::Client.new(access_token: "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")
  
    messages_for_openai = Message.for_openai(chat.messages)
    puts "Messages for OpenAI: #{messages_for_openai.inspect}" # Debugging statement
  
    response = openai_client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: messages_for_openai,
        temperature: 0.1
      }
    )
  
    puts "API Response: #{response.inspect}" # Debugging statement
  
    new_content = response.dig("choices", 0, "message", "content")
    if new_content.present?
      message.update(content: new_content)
      message.broadcast_created
    end
  end
  
end
