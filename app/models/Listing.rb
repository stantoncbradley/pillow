class Listing < ActiveRecord::Base

  belongs_to :property

  enum status: { unavailable: 0, reserved: 1, available: 2 }
end