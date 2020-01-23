# frozen_string_literal: true

require 'yaml'

class HotelService
  attr_reader :hotel_data
  attr_reader :suppliers_config

  def initialize(hotel_data)
    @hotel_data = hotel_data
    @suppliers_config = YAML.load_file(Rails.root.join('config/suppliers.yml'))['extract']
  end

  def save
    hotel = Hotel.find_or_create_by(hotel_id: fetch_data('hotel_id'), destination_id: fetch_data('destination_id'))
    hotel.update hotel_attrs(hotel)
  end

  private

  def hotel_attrs(hotel)
    {
      name: merge_by_length(hotel.name, fetch_data('name')),
      location: merge_hash_data(hotel.location, location),
      description: merge_by_length(hotel.description, fetch_data('description')),
      amenities: merge_by_length(hotel.amenities, fetch_data('amenities')),
      images: merge_hash_data(hotel.images, images),
      booking_conditions: fetch_data('booking_conditions') || hotel.booking_conditions
    }
  end

  def merge_hash_data(source, dest)
    (source || {}).merge(dest) do |_k, oldval, newval|
      merge_by_length(newval, oldval)
    end
  end

  def merge_by_length(source, dest)
    return source unless dest
    return dest unless source

    dest.to_s.length > source.to_s.length ? dest : source
  end

  def fetch_data(field)
    result = nil
    suppliers_config[field].each do |tag|
      result ||= get_newval(field, tag)
    end
    result
  end

  def get_newval(field, tag)
    newval = if tag.include?(',')
               paths = tag.split(',')
               hotel_data.dig(*paths) if hotel_data[paths.first].is_a?(Hash)
             else
               hotel_data[tag]
             end
    if suppliers_config['string_fields'].include?(field) && newval.is_a?(Hash)
      newval = newval.values.compact.join(', ')
    end
    newval
  end

  def location
    {
      'lat' => fetch_data('lat'),
      'lng' => fetch_data('long'),
      'address' => fetch_data('address'),
      'city' => fetch_data('city'),
      'country' => fetch_data('country')
    }
  end

  def images
    room_images = organize_image_info fetch_data('room_images')
    site_images = organize_image_info fetch_data('site_images')
    amenities_images = organize_image_info fetch_data('amenities_images')
    {
      'rooms' => room_images,
      'site' => site_images,
      'amenities' => amenities_images
    }
  end

  def organize_image_info(images)
    return if images.blank?

    images.each do |image|
      image['link'] = image.delete 'url' if image['url'].present?
      image['description'] = image.delete 'caption' if image['caption'].present?
    end
  end
end
