class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :property_id, null: false
      t.date :date, null: false
      t.integer :status, null: false
      t.integer :price
    end
  end
end
