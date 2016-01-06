class AddConstraints < ActiveRecord::Migration
  def change
    add_index :properties, :zipcode
    add_index :properties, :bedrooms
    add_index :listings, [:property_id, :date], unique: true
    add_index :listings, :price
    add_foreign_key :listings, :properties
  end
end
