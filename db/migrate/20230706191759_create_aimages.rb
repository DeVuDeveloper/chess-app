class CreateAimages < ActiveRecord::Migration[7.0]
  def change
    create_table :aimages do |t|
      t.string :prompt
      t.string :size
      t.string :url

      t.timestamps
    end
  end
end