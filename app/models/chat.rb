# app/models/chat.rb
class Chat < ApplicationRecord
    has_many :messages, dependent: :destroy
    
    scope :ordered, -> { order(id: :desc) }

     
  end
  