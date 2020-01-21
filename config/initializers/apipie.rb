# frozen_string_literal: true

Apipie.configure do |config|
  config.app_name                = 'HotelApp'
  config.api_base_url            = '/api'
  config.doc_base_url            = '/apipie'
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.translate = false
  config.default_locale = nil
  config.copyright = '&copy; 2020 Phan Trung Kien'
  config.app_info['1.0'] = "
    This is where you can inform user about your application and API
    in general.
  "
end
