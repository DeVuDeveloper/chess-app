class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(chat) { "chats" }, inserts_by: :prepend
  after_create_commit -> { broadcast_append_to "chats", partial: "chats/chat_window", locals: { chat: self }, target: "chats" }
end
