class UserGame < ApplicationRecord
  belongs_to :game
  belongs_to :user

  # Add this line to define the `joined` attribute as a boolean column
  attribute :joined, :boolean, default: false
end
