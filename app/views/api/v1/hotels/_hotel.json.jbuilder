# frozen_string_literal: true

json.id hotel.supplier_id
json.extract! hotel, :destination_id, :name, :location, :description,
              :amenities, :images, :booking_conditions
