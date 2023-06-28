# app/models/chat.rb
class Chat < ApplicationRecord
    has_many :messages, dependent: :destroy
  end
  