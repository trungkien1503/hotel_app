# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Hotels', type: :request do
  before do
    CrawlService.new.call
  end
  describe 'GET /v1/hotels.json' do
    it 'Show list of hotels without parameters' do
      get v1_hotels_path(format: 'json')
      expect(response).to have_http_status(200)
      hotels = JSON.parse(response.body)
      expect(hotels.count).to eq(3)
    end

    it 'works with param hotels' do
      get v1_hotels_path(format: 'json', hotels: 'f8c9,SjyX')
      expect(response).to have_http_status(200)
      hotels = JSON.parse(response.body)
      hotel_ids = hotels.map { |h| h['id'] }
      expect(hotels.count).to eq(2)
      expect(hotel_ids).to include('f8c9', 'SjyX')
    end

    it 'works with both of params hotels and destination_id' do
      get v1_hotels_path(format: 'json', hotels: 'f8c9,SjyX', destination_id: 5432)
      expect(response).to have_http_status(200)
      hotels = JSON.parse(response.body)
      hotel_ids = hotels.map { |h| h['id'] }
      expect(hotels.count).to eq(1)
      expect(hotel_ids).to_not include('f8c9')
    end
  end

  describe 'GET /v1/hotels/hotelId.json' do
    it 'show detail of the hotel' do
      get v1_hotel_path(format: 'json', id: 'f8c9')
      expect(response).to have_http_status(200)
      hotel = JSON.parse(response.body)
      expect(hotel['id']).to eq('f8c9')
      expect(hotel['destination_id']).to eq 1122
    end
  end
end
