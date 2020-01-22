# frozen_string_literal: true

class HotelService
  attr_reader :hotel_data

  def initialize(hotel_data)
    @hotel_data = hotel_data
  end

  def save
    hotel = Hotel.find_or_create_by(hotel_id: hotel_id, destination_id: destination_id)
    hotel.update hotel_attrs(hotel)
  end

  private

  def hotel_attrs(hotel)
    {
      name: merge_by_length(hotel.name, name),
      location: merge_hash_data(hotel.location, location),
      description: merge_by_length(hotel.description, description),
      amenities: merge_by_length(hotel.amenities, amenities),
      images: merge_hash_data(hotel.images, images),
      booking_conditions: booking_conditions || hotel.booking_conditions
    }
  end

  def merge_hash_data(source, dest)
    (source || {}).merge(dest) do |_k, oldval, newval|
      is_change = newval.to_s.length > oldval.to_s.length
      is_change ? newval : oldval
    end
  end

  def merge_by_length(source, dest)
    return source unless dest
    return dest unless source

    dest.length > source.length ? dest : source
  end

  def hotel_id
    hotel_data['Id'] || hotel_data['id'] || hotel_data['hotel_id'] ||
      hotel_data['HotelId'] || hotel_data['_id']
  end

  def destination_id
    hotel_data['DestinationId'] || hotel_data['destination'] ||
      hotel_data['destination_id'] || hotel_data['_location_id']
  end

  def name
    hotel_data['Name'] || hotel_data['hotel_name'] || hotel_data['name']
  end

  def location
    {
      'lat' => lat,
      'lng' => lng,
      'address' => address,
      'city' => city,
      'country' => country
    }
  end

  def lat
    hotel_data['Latitude'] || hotel_data['lat']
  end

  def lng
    hotel_data['Longitude'] || hotel_data['lng'] || hotel_data['long']
  end

  def address
    if hotel_data['Address'].is_a?(Hash)
      hotel_data['Address'].values.compact.map(&:strip).join(', ')
    elsif hotel_data['address'].is_a?(Hash)
      hotel_data['address']['formatted']
    else
      hotel_data['Address'] || hotel_data.dig('location', 'address') || hotel_data['address']
    end
  end

  def city
    hotel_data['City'] || (hotel_data.dig('address', 'city') if hotel_data['address'].is_a?(Hash))
  end

  def country
    hotel_data.dig('location', 'country') || hotel_data['Country'] ||
      (hotel_data.dig('address', 'country') if hotel_data['address'].is_a?(Hash))
  end

  def description
    hotel_data['details'] || hotel_data['Description'] || hotel_data['info'] ||
      hotel_data['detail']
  end

  def amenities
    if hotel_data['amenities'].is_a?(Hash)
      hotel_data['amenities']
    else
      { 'general': (hotel_data['amenities'] || hotel_data['Facilities']) }
    end
  end

  def images
    if hotel_data['Images'].is_a?(Array)
      {
        'rooms' => hotel_data['Images']
      }
    elsif hotel_data['images'].is_a?(Array)
      rooms_result = []
      hotel_data['images'].each do |image|
        rooms_result << { 'link' => image }
      end
      {
        'rooms' => rooms_result
      }
    else
      room_images = organize_image_info hotel_data.dig('images', 'rooms')
      site_images = organize_image_info hotel_data.dig('images', 'site')
      amenities_images = organize_image_info hotel_data.dig('images', 'amenities')
      {
        'rooms' => room_images,
        'site' => site_images,
        'amenities' => amenities_images
      }
    end
  end

  def booking_conditions
    hotel_data['booking_conditions']
  end

  def organize_image_info(images)
    return if images.blank?

    images.each do |image|
      image['link'] = image.delete 'url' if image['url'].present?
      image['description'] = image.delete 'caption' if image['caption'].present?
    end
  end
end
