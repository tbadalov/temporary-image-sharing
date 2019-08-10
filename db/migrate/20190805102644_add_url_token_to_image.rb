class AddUrlTokenToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :control_hash, :string
    add_index :images, :control_hash, unique: true
  end
end
