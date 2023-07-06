class AddLoaderToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :loader, :boolean, default: false
  end
end
