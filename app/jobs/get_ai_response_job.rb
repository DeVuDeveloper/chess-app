require 'sidekiq'

class GetAiResponseJob < SidekiqJob

  def perform(chat_id)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)
    message = chat.messages.create(role: "assistant", content: "loading", loader: true)
  
    openai_client = OpenAI::Client.new(access_token: "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")
    messages_for_openai = Message.for_openai(chat.messages)
  
    response = openai_client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: messages_for_openai,
        temperature: 0.1
      }
    )
  
    new_content = response.dig("choices", 0, "message", "content")
    if new_content.present?
      message.update(content: new_content, loader: false)
    end
  end
end