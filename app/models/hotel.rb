# frozen_string_literal: true

# Handle Hotel table
class Hotel < ApplicationRecord
  serialize :booking_conditions, Array

  validates :hotel_id, :destination_id, presence: true

  def self.search(options)
    hotels = Hotel.all
    hotels = hotels.where(destination_id: options[:destination_id]) if options[:destination_id]
    if options[:hotels].present?
      match_hotels = options[:hotels].split(',')
      hotels = hotels.where(hotel_id: match_hotels)
    end
    hotels
  end
end
