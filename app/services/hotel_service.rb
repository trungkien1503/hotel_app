# frozen_string_literal: true

class HotelService
  attr_reader :hotel_data

  def initialize(hotel_data)
    @hotel_data = hotel_data
  end

  def save
    hotel = Hotel.find_or_create_by(hotel_id: hotel_id, destination_id: destination_id)
    hotel_attrs = {
      name: name || hotel.name,
      location: (hotel.location || {}).merge(location) { |_key, oldval, newval| newval || oldval },
      description: description || hotel.description,
      amenities: (hotel.amenities || {}).merge(amenities) { |_key, oldval, newval| newval || oldval },
      images: (hotel.images || {}).merge(images) { |_key, oldval, newval| newval || oldval },
      booking_conditions: booking_conditions || hotel.booking_conditions
    }
    hotel.update(hotel_attrs)
  end

  private

  def hotel_id
    hotel_data['Id'] || hotel_data['id'] || hotel_data['hotel_id']
  end

  def destination_id
    hotel_data['DestinationId'] || hotel_data['destination'] || hotel_data['destination_id']
  end

  def name
    hotel_data['Name'] || hotel_data['hotel_name']
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
    hotel_data['Longitude'] || hotel_data['lng']
  end

  def address
    hotel_data['Address'] || hotel_data.dig('location', 'address') || hotel_data['address']
  end

  def city
    hotel_data['City']
  end

  def country
    hotel_data.dig('location', 'country') || hotel_data['Country']
  end

  def description
    hotel_data['details'] || hotel_data['Description'] || hotel_data['info']
  end

  def amenities
    if hotel_data['amenities'].is_a?(Hash)
      hotel_data['amenities']
    else
      { 'general': (hotel_data['amenities'] || hotel_data['Facilities']) }
    end
  end

  def images
    room_images = organize_image_info hotel_data.dig('images', 'rooms')
    site_images = organize_image_info hotel_data.dig('images', 'site')
    amenities_images = organize_image_info hotel_data.dig('images', 'amenities')
    {
      'rooms' => room_images,
      'site' => site_images,
      'amenities' => amenities_images
    }
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
