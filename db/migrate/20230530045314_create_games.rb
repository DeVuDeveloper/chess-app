class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :state
      t.integer :white_player_user_id
      t.integer :black_player_user_id
      t.integer :winner_user_id
      t.integer :loser_user_id
      t.integer :turn_user_id
      t.timestamps
    end

    add_index :games, :name
  end
end
