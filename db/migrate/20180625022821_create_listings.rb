class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :headline
      t.string :description
      t.string :photo_url
      t.integer :channel_id
      t.integer :external_id
      t.integer :accommodates
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :beds
      t.float :lat
      t.float :lng
      t.string :city

      t.timestamps
    end

    add_index :listings, :channel_id
    add_index :listings, :external_id
    add_index :listings, :accommodates
    add_index :listings, :bedrooms
  end
end
