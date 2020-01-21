# frozen_string_literal: true

class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :hotel_id, null: false
      t.integer :destination_id, null: false
      t.string :name
      t.json :location
      t.string :description
      t.json :amenities
      t.json :images
      t.text :booking_conditions

      t.timestamps
    end
  end
end
