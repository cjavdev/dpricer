class CreateListingDays < ActiveRecord::Migration[5.1]
  def change
    create_table :listing_days do |t|
      t.integer :listing_id, null: false
      t.integer :price, null: false
      t.date :price_on, null: false
      t.boolean :blocked, default: false

      t.timestamps
    end
    add_index :listing_days, :listing_id
  end
end
