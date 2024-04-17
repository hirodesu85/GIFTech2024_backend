class CreateBottoms < ActiveRecord::Migration[7.1]
  def change
    create_table :bottoms do |t|
      t.string :name, limit: 30, null: false
      t.string :image_url, limit: 80, null: false
      t.boolean :is_mine, null: false, default: false

      t.timestamps
    end
  end
end
