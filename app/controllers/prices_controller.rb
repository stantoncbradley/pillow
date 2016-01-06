class PricesController < ApplicationController

  require 'linear_regression'

  def create
    raise 'bedrooms must be integer' unless params[:bedrooms].is_i?
    raise 'zipcode must be integer' unless params[:zipcode].is_i?
    bedroom_count = params[:bedrooms].to_i
    raise 'bedrooms cannot be negative' if bedroom_count < 0

    listings = Listing.includes(:property)
                 .where(properties: {zipcode: params[:zipcode]})
                 .where.not(price: nil, properties: {bedrooms: nil})

    if listings.empty?
      price = nil
    else
      bedrooms = []
      prices = []
      listings.each do |l|
        bedrooms.push(l.property.bedrooms)
        prices.push(l.price)
      end
      linear_regression = LinearRegression.new(bedrooms, prices)
      price = linear_regression.slope * bedroom_count + linear_regression.y_intercept
    end

    render json: {price: price}
  end

end