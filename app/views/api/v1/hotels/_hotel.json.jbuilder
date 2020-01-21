# frozen_string_literal: true

json.id hotel.hotel_id
json.extract! hotel, :destination_id, :name, :location, :description,
              :amenities, :images, :booking_conditions
