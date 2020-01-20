# frozen_string_literal: true

json.array! @hotels, partial: 'hotels/hotel', as: :hotel
