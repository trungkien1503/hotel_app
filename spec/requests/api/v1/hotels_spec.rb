# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Hotels', type: :request do
  before do
    Hotel.crawling_data
  end
  describe 'GET /v1/hotels.json' do
    it 'Show list of hotels with parameters' do
      get v1_hotels_path(format: 'json')
      expect(response).to have_http_status(200)
    end
  end
end
