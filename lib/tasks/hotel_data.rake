# frozen_string_literal: true

namespace :hotel_data do
  desc 'Get and merge hotel data from suppliers'

  task crawl: :environment do
    puts 'Start getting and merging hotel data'
    CrawlService.new.call
    puts 'Finish!'
  end
end
