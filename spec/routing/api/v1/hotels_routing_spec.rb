# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::HotelsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/hotels.json').to route_to('api/v1/hotels#index', format: 'json')
    end

    it 'routes to #show' do
      dest_route = route_to('api/v1/hotels#show', id: 'xYz', format: 'json')
      expect(get: '/v1/hotels/xYz.json').to dest_route
    end
  end
end
