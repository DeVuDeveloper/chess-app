class Game < ApplicationRecord
  has_many :user_games
  has_many :users, through: :user_games


  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(game) { "games" }, inserts_by: :prepend

  def white_player
    User.find_by_id(white_player_user_id)
  end

  def black_player
    User.find_by_id(black_player_user_id)
  end

end
  