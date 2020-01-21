# frozen_string_literal: true

json.array! @hotels, partial: 'api/v1/hotels/hotel', as: :hotel
