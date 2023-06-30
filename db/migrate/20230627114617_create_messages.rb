class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :chat
      t.integer :role, null: false, default: 0
      t.string :content

      t.timestamps
    end
  end
end
