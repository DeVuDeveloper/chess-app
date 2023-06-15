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

    # Retrieve the assistant's response from the API response
    assistant_response = response["choices"][0]["message"]["content"]

    # Update the assistant message with the response
    message.update(content: assistant_response)
    puts "Message updated with ID: #{message.id}, content: '#{message.content}'"

    # Broadcast the updated message to the chat
    message.broadcast_updated
  end
end
