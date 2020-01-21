# frozen_string_literal: true

module Api
  module V1
    # Controller handle requests to v1/hotels
    class HotelsController < ApiController
      include ::Hotels::IndexDoc
      include ::Hotels::ShowDoc
      before_action :set_hotel, only: :show

      def index
        @hotels = Hotel.search(search_params)
      end

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
end
