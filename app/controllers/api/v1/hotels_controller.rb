# frozen_string_literal: true

module Api::V1
  class HotelsController < ApiController
    before_action :set_hotel, only: :show

    # GET /hotels.json
    def index
      @hotels = Hotel.all
    end

    # GET /hotels/iJhz.json
    def show; end

    private

    def set_hotel
      @hotel = Hotel.find_by!(supplier_id: params[:id])
    end
  end
end
