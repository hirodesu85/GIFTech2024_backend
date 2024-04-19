class AlterItemsImageUrlLength < ActiveRecord::Migration[7.1]
  def change
    change_column :bottoms, :image_url, :string, limit: 120, null: false
    change_column :hairs, :image_url, :string, limit: 120, null: false
    change_column :shoes, :image_url, :string, limit: 120, null: false
    change_column :tops, :image_url, :string, limit: 120, null: false
  end
end
