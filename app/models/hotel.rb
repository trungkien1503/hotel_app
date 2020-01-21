# frozen_string_literal: true

# Handle Hotel table

class Hotel < ApplicationRecord
  serialize :booking_conditions, Array

  SUPPLIERS = %w[
    https://api.myjson.com/bins/gdmqa
    https://api.myjson.com/bins/1fva3m
    https://api.myjson.com/bins/j6kzm
  ].freeze

  validates :supplier_id, :destination_id, presence: true

  def self.crawling_data
    Hotel.destroy_all
    SUPPLIERS.each do |supplier_url|
      supplier_data = open(supplier_url).read
      hotels = JSON.parse(supplier_data)
      hotels.each do |hotel_data|
        hotel_service = HotelService.new(hotel_data).save
      end
    end
  end
end
