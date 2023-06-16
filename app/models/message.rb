class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  enum role: { system: 0, assistant: 10, user: 20 }

  belongs_to :chat

  after_create_commit -> { broadcast_created }
  after_update_commit -> { broadcast_replaced }

  def broadcast_created
    broadcast_append_to(
      "#{dom_id(chat)}_messages",
      partial: "messages/message",
      locals: { message: self, scroll_to: true },
      target: "#{dom_id(self)}_messages"
    )
    chat.reload
  end
  
  def broadcast_replaced
    broadcast_replace_to(
      "#{dom_id(chat)}_messages",
      partial: "messages/message",
      locals: { message: self, scroll_to: true },
      target: "#{dom_id(self)}_messages"
    )
  end

  def self.for_openai(messages)
    messages.map { |message| { role: message.role, content: message.content } }
  end

  def assistant_message?
    role == "assistant"
  end
end
