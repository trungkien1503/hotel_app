# frozen_string_literal: true

class Hotel < ApplicationRecord
  serialize :booking_conditions, Array

  SUPPLIERS = %w[
    https://api.myjson.com/bins/gdmqa
    https://api.myjson.com/bins/1fva3m
    https://api.myjson.com/bins/j6kzm
  ].freeze
end
