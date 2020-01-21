# frozen_string_literal: true

require 'open-uri'
# Handle Hotel table
class Hotel < ApplicationRecord
  serialize :booking_conditions, Array

  SUPPLIERS = %w[
    https://api.myjson.com/bins/gdmqa
    https://api.myjson.com/bins/1fva3m
    https://api.myjson.com/bins/j6kzm
  ].freeze

  validates :hotel_id, :destination_id, presence: true

  def self.crawling_data
    Hotel.destroy_all
    SUPPLIERS.each do |supplier_url|
      supplier_data = URI.parse(supplier_url).read
      hotels = JSON.parse(supplier_data)
      hotels.each do |hotel_data|
        HotelService.new(hotel_data).save
      end
    end
  end

  def self.search(options)
    hotels = Hotel.all
    hotels = hotels.where(destination_id: options[:destination_id]) if options[:destination_id]
    if options[:hotels].present?
      match_hotels = options[:hotels].split(',')
      hotels = hotels.where(hotel_id: match_hotels)
    end
    hotels.uniq
  end
end
