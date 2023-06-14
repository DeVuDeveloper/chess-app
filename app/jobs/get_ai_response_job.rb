class GetAiResponseJob < ApplicationJob
   queue_as :default
  def perform(chat_id)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)
    message = chat.messages.create(role: "assistant", content: "")
    puts "Message created with ID: #{message.id}, content: '#{message.content}'"
    message.broadcast_created
  
    openai_client = OpenAI::Client.new(access_token: "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")
  
    response = openai_client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: Message.for_openai(chat.messages),
        temperature: 0.1
      }
    )
  
    puts "API response: #{response.inspect}"
  end
  

  def stream_proc(message:)
    proc do |chunk, _bytesize|
      puts "Chunk: #{chunk.inspect}"
      new_content = chunk.dig("choices", 0, "delta", "content")
      puts "New content: #{new_content.inspect}"
      if new_content
        message.update(content: message.content + new_content)
        puts "Message updated with ID: #{message.id}, content: '#{message.content}'"
      end
    end
  end
end