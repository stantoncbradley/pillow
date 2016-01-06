class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :zipcode, null: false
      t.integer :bedrooms
      t.integer :accomodates, null: false
    end
  end
end
