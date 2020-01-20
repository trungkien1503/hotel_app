# frozen_string_literal: true

require 'open-uri'
require 'JSON'

namespace :hotel_data do
  desc 'Get and merge hotel data from suppliers'

  task crawl: :environment do
    puts 'Start getting and merging hotel data'
    Hotel.destroy_all
    Hotel::SUPPLIERS.each do |supplier_url|
      supplier_data = open(supplier_url).read
      hotels = JSON.parse(supplier_data)
      hotels.each do |hotel_data|
        hotel_service = HotelService.new(hotel_data).save
      end
    end
    puts 'Finish!'
  end
end
