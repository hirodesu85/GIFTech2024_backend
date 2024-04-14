class CreateBeautyGirls < ActiveRecord::Migration[7.1]
  def change
    create_table :beauty_girls, id: :bigint, unsigned: true, auto_increment: true do |t|
      t.string :name, null: false, limit: 30
      t.integer :rank, null: false, default: 0, unsigned: true, limit: 2
      t.integer :until_next_rank, null: false, default: 1, unsigned: true
      t.integer :hair_id, null: false, default: 1, unsigned: true
      t.integer :shoes_id, null: false, default: 1, unsigned: true
      t.integer :tops_id, null: false, default: 1, unsigned: true
      t.integer :bottoms_id, null: false, default: 1, unsigned: true

      t.timestamps
    end
  end
end
