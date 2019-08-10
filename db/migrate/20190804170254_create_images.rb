class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.datetime :expires_at

      t.timestamps
    end
  end
end
