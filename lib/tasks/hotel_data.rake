# frozen_string_literal: true

require 'open-uri'
require 'JSON'

namespace :hotel_data do
  desc 'Get and merge hotel data from suppliers'

  task crawl: :environment do
    puts 'Start getting and merging hotel data'
    Hotel.crawling_data
    puts 'Finish!'
  end
end
