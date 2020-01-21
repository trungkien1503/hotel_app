# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::HotelsController, type: :controller do
  before do
    Hotel.crawling_data
  end
  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, format: 'json'
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: Hotel.first.hotel_id }, format: 'json'
      expect(response).to be_successful
    end
  end
end
