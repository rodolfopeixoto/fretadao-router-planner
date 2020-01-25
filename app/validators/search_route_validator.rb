class SearchRouteValidator < ApplicationValidator
  
  attr_reader :map, :source, :destination, :autonomy_km, :amount_liter

  LETTERS_ONLY_REGEX = /[a-zA-Z]/
  NUMBERS_ONLY_REGEX = /[0-9]/

  def initialize(map, source, destination, autonomy_km, amount_liter)
    @map = map
    @source = source
    @destination = destination
    @autonomy_km = autonomy_km
    @amount_liter = amount_liter
  end

  def call
    valid_fields? && fields_is_not_empty?
  end

  private

  def valid_fields?
    valid = valid_source_and_destination? && valid_autonomy_km?
    valid && valid_map?
  end
  
  def valid_map?
    !map.empty? && map.match?(LETTERS_ONLY_REGEX)
  end

  def valid_source_and_destination?
    source.match?(LETTERS_ONLY_REGEX) && destination.match?(LETTERS_ONLY_REGEX)
  end
  
  def valid_autonomy_km?
    autonomy_km.match?(NUMBERS_ONLY_REGEX)
  end

  def fields_is_not_empty?
    valid = !autonomy_km.empty? || !amount_liter.empty? 
    valid || !destination.empty? || !source.empty?
  end
end
