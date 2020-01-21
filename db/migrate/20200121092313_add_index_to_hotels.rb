# frozen_string_literal: true

class AddIndexToHotels < ActiveRecord::Migration[5.2]
  def change
    add_index :hotels, :hotel_id, unique: true
  end
end
