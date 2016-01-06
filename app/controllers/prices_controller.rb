class PricesController < ApplicationController

  require 'linear_regression'

  def create
    listings = Listing.includes(:property).where(properties: {zipcode: params[:zipcode]}).where.not(price: nil)
    if listings.empty?
      price = null
    else
      bedrooms = []
      prices = []
      listings.each do |l|
        unless l.property.bedrooms.nil?
          bedrooms.push(l.property.bedrooms)
          prices.push(l.price)
        end
      end
      linear_regression = LinearRegression.new(bedrooms, prices)

      price = linear_regression.slope * params[:bedrooms].to_i + linear_regression.y_intercept
    end
    render json: {price: price}
  end

end