class CreateVisitedPlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :visited_places do |t|
      t.text :place_id, null: false
      t.timestamps
    end
  end
end
