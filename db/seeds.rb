# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

namespace :db do
  task :seed => [:environment] do

    require 'Date'
    require 'CSV'

    file_name = 'db/data/data_challenge.csv'
    file = File.open(file_name)
    csv = CSV.new(file, :headers => true, :converters => [:all])

    ActiveRecord::Base.transaction do
      csv.each do |row|
        row = row.to_hash
        row['id'] = row.delete 'property_id'
        listings = row.slice!('id','zipcode','bedrooms','accomodates')
        property = Property.create!(row)
        puts "Created property id: #{property.id}"

        listings.each do |k, v|
          listing = Listing.new({
                                  property_id: property.id,
                                  date: Date.strptime(k, '%m/%d/%Y')
                                })
          if v.is_a? Numeric
            listing.status = 'available'
            listing.price = v.to_i
          else
            listing.status = v
          end
          listing.save!
          puts "Created listing for property: #{listing.property_id}, date: #{listing.date}"
        end

      end
    end

  end
end