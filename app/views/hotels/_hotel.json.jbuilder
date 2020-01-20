# frozen_string_literal: true

json.extract! hotel, :id, :supplier_id, :destination_id, :name, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
