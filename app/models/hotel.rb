# frozen_string_literal: true

require 'open-uri'
require 'yaml'

# Handle Hotel table
class Hotel < ApplicationRecord
  serialize :booking_conditions, Array

  validates :hotel_id, :destination_id, presence: true

  def self.crawling_data
    Hotel.destroy_all
    suppliers_config = YAML.load_file(Rails.root.join('config/suppliers.yml')) || {}
    suppliers_config['suppliers'].each do |supplier_url|
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
