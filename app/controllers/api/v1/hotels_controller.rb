# frozen_string_literal: true

module Api::V1
  class HotelsController < ApiController
    before_action :set_hotel, only: :show

    # GET /hotels.json
    def index
      @hotels = Hotel.search(search_params)
    end

    # GET /hotels/iJhz.json
    def show; end

    private

    def set_hotel
      @hotel = Hotel.find_by!(hotel_id: params[:id])
    end

    def search_params
      params.permit(:hotels, :destination_id)
    end
  end
end
