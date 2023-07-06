class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :prompt
      t.string :size
      t.string :url

      t.timestamps
    end
  end
end