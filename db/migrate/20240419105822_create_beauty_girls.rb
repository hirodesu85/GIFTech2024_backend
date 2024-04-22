class CreateBeautyGirls < ActiveRecord::Migration[7.1]
  def change
    create_table :beauty_girls do |t|
      t.integer :rank, limit: 2, null: false, default: 1
      t.integer :until_next_rank, null: false, default: 1
      t.integer :hairs_id, limit: 8, null: false, default: 1
      t.integer :shoes_id, limit: 8, null: false, default: 1
      t.integer :tops_id, limit: 8, null: false, default: 1
      t.integer :bottoms_id, limit: 8, null: false, default: 1

      t.timestamps
    end
  end
end
