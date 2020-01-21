# frozen_string_literal: true

module Hotels
  # Doc for api v1/hotels/hotel_id.json
  module ShowDoc
    extend Apipie::DSL::Concern

    api :GET, '/v1/hotels/:hotel_id.json', 'Show the detail info of a hotel'
    param :id, String, 'hotel_id ex: iJhz', required: true

    example <<-EOS
      {
        "id": "iJhz",
        "destination_id": 5432,
        "name": "Beach Villas Singapore",
        "location": {
          "lat": 1.264751,
          "lng": 103.824006,
          "address": "8 Sentosa Gateway, Beach Villas, 098269",
          "city": "Singapore",
          "country": "Singapore"
        },
        "description": "Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.",
        "amenities": {
          "general": [
            "Aircon",
            "Tv",
            "Coffee machine",
            "Kettle",
            "Hair dryer",
            "Iron",
            "Tub"
          ],
          "room": [
            "tv",
            "coffee machine",
            "kettle",
            "hair dryer",
            "iron"
          ]
        },
        "images": {
          "rooms": [
            {
              "description": "Double room",
              "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg"
            },
            {
              "description": "Bathroom",
              "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg"
            }
          ],
          "site": [
            {
              "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg",
              "description": "Front"
            }
          ],
          "amenities": [
            {
              "description": "RWS",
              "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg"
            },
            {
              "description": "Sentosa Gateway",
              "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg"
            }
          ]
        },
        "booking_conditions": [
          "All children are welcome. One child under 12 years stays free of charge when using existing beds. One child under 2 years stays free of charge in a child's cot/crib. One child under 4 years stays free of charge when using existing beds. One older child or adult is charged SGD 82.39 per person per night in an extra bed. The maximum number of children's cots/cribs in a room is 1. There is no capacity for extra beds in the room.",
          "Pets are not allowed.",
          "WiFi is available in all areas and is free of charge.",
          "Free private parking is possible on site (reservation is not needed).",
          "Guests are required to show a photo identification and credit card upon check-in. Please note that all Special Requests are subject to availability and additional charges may apply. Payment before arrival via bank transfer is required. The property will contact you after you book to provide instructions. Please note that the full amount of the reservation is due before arrival. Resorts World Sentosa will send a confirmation with detailed payment information. After full payment is taken, the property's details, including the address and where to collect keys, will be emailed to you. Bag checks will be conducted prior to entry to Adventure Cove Waterpark. === Upon check-in, guests will be provided with complimentary Sentosa Pass (monorail) to enjoy unlimited transportation between Sentosa Island and Harbour Front (VivoCity). === Prepayment for non refundable bookings will be charged by RWS Call Centre. === All guests can enjoy complimentary parking during their stay, limited to one exit from the hotel per day. === Room reservation charges will be charged upon check-in. Credit card provided upon reservation is for guarantee purpose. === For reservations made with inclusive breakfast, please note that breakfast is applicable only for number of adults paid in the room rate. Any children or additional adults are charged separately for breakfast and are to paid directly to the hotel."
        ]
      }
    EOS

    def show; end
  end
end
