class LogisticMeshesValidator < ApplicationValidator
  
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
    return true if valid_params?
    false
  end

  private
  
  def valid_params?
    return false unless valid_source_and_destination?
    return false unless valid_autonomy_km?
    return false if fields_empty?
    return false unless amount_liter.kind_of?(Float)
    return false unless valid_map?
    true
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

  def fields_empty?
    autonomy_km.empty? || amount_liter.empty? || destination.empty? || source.empty?
  end
end
