class CreateTops < ActiveRecord::Migration[7.1]
  def change
    create_table, id: :integer, unsigned: true, auto_increment: true do |t|
      t.string :name, null: false, limit: 30
      t.string :image_url, null: false, limit: 80
      t.boolean :is_mine, null: false, default: false

      t.timestamps
  end
end
