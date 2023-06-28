# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :chat, optional: true
  belongs_to :user

  broadcasts_to ->(message) { "messages" }, inserts_by: :prepend

  validate :chat_must_exist

  private

  def chat_must_exist
    errors.add(:chat, "must exist") unless chat.present?
  end
end
