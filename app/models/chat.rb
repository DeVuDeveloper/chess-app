class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
    
  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(chat) { "chats" }, inserts_by: :prepend
end
  