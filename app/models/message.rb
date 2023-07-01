class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  enum role: { system: 0, assistant: 10, user: 20 }

  belongs_to :chat, optional: true

  scope :ordered, -> { order(id: :desc) }
  

  broadcasts_to ->(message) { "messages" }, inserts_by: :append

  after_create_commit -> { broadcast_created }
  after_update_commit -> { broadcast_updated }

  validate :chat_must_exist

  def broadcast_created
    target = "#{dom_id(chat)}_messages"
    puts "Broadcasting 'append' action to #{target} with partial 'messages/message'"

    broadcast_append_later_to(
      target,
      partial: "messages/message",
      locals: { message: self, scroll_to: true },
      target: target
    )
  end

  def broadcast_updated
    target = "#{dom_id(chat)}_messages"
    puts "Broadcasting 'append' action to #{target} with partial 'messages/message'"

    broadcast_append_to(
      target,
      partial: "messages/message",
      locals: { message: self, scroll_to: true },
      target: target
    )
  end

  def self.for_openai(messages)
    messages.map { |message| { role: message.role, content: message.content } }
  end

  def assistant_message?
    role == "assistant"
  end

  private

  def chat_must_exist
    errors.add(:chat, "must exist") unless chat.present?
  end
end
