require 'rails_helper'

describe PricesController do

  context 'Create' do

    before :each do
      @params = {}
    end

    context 'valid request' do

      it 'returns correct price for given zipcode and bedroom count' do
        @params[:bedrooms] = '4'
        @params[:zipcode] = '94109'
        post(:create, @params)
        expect(response.status).to eql 200
        json = JSON.parse(response.body)
        expect(json['price']).to eql(793.7287953571977)
      end

      it 'returns null if zipcode does not exist' do
        @params[:bedrooms] = '4'
        @params[:zipcode] = '63701'
        post(:create, @params)
        expect(response.status).to eql 200
        json = JSON.parse(response.body)
        expect(json['price']).to be_nil
      end

      it 'works for ridiculous amount of rooms' do
        @params[:bedrooms] = '50'
        @params[:zipcode] = '94109'
        post(:create, @params)
        expect(response.status).to eql 200
        json = JSON.parse(response.body)
        expect(json['price']).to eql(9725.188299937838)
      end

      it 'works for 0 rooms' do
        @params[:bedrooms] = '0'
        @params[:zipcode] = '94109'
        post(:create, @params)
        expect(response.status).to eql 200
        json = JSON.parse(response.body)
        expect(json['price']).to eql(17.080142784968018)
      end

    end

    context 'invalid request' do

      it 'raises error if bedrooms is NaN' do
        @params[:bedrooms] = 'NaN'
        @params[:zipcode] = '94109'
        expect {post(:create, @params) }.to raise_error 'bedrooms must be integer'
      end

      it 'raises error if zipcode is NaN' do
        @params[:bedrooms] = '4'
        @params[:zipcode] = 'NaN'
        expect {post(:create, @params) }.to raise_error 'zipcode must be integer'
      end

      it 'raises error if bedrooms is negative' do
        @params[:bedrooms] = '-3'
        @params[:zipcode] = '94109'
        expect {post(:create, @params) }.to raise_error 'bedrooms cannot be negative'
      end

    end

  end
end