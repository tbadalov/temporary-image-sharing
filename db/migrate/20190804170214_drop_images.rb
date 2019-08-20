class DropImages < ActiveRecord::Migration[5.2]
  def change
    drop_table :images, if_exists: true
  end
end
