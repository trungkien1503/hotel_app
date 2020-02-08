# frozen_string_literal: true

require 'open-uri'

class CrawlService
  TIMEOUT = 5
  THREATS_SIZE = 8

  def call
    suppliers_config = YAML.load_file(Rails.root.join('config/suppliers.yml')) || {}
    Parallel.each(suppliers_config['suppliers'], in_threads: THREATS_SIZE) do |supplier_url|
      Rails.application.executor.wrap do
        executor_hotel(supplier_url)
      end
    end
  end

  private

  def executor_hotel(supplier_url)
    ActiveRecord::Base.connection_pool.with_connection do
      hotels = fetch_hotels(supplier_url)
      Hotel.transaction do
        hotels.each do |hotel_data|
          HotelService.new(hotel_data).save
        end
      end
    end
  end

  def fetch_hotels(url)
    supplier_data = URI.parse(url).read(read_timeout: TIMEOUT)
    JSON.parse(supplier_data)
  rescue StandardError => e
    Rails.logger.error "Error when parsing url from supplier: #{url} with #{e.message}"
    []
  end
end
