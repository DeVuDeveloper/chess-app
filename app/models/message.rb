class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  enum role: { system: 0, assistant: 10, user: 20 }

  belongs_to :chat, optional: true

  broadcasts_to ->(message) { "messages" }, inserts_by: :append

  scope :ordered, -> { order(id: :desc) }

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
