class LogisticMeshesValidator < ApplicationValidator
  
  attr_reader :map, :routes

  LETTERS_ONLY_REGEX = /[a-zA-Z]/
  NUMBERS_ONLY_REGEX = /[0-9]/
  NUMBER_PARAMS_VALID_ROUTES = 3

  def initialize(map, routes)
    @map = map
    @routes = routes
  end

  def call
    return true if valid_routes?
    false
  end

  def valid_map?
    !map.empty? && map.match?(LETTERS_ONLY_REGEX)
  end

  def valid_routes?
    return false unless routes.kind_of?(Array)
    routes.map do |route|
      route_array = route.split(' ')
      false unless route.empty?
      false unless valid_source_and_destination?(route_array) && valid_weigth?(route_array)
      false unless valid_size?(route)
      true
    end.include?(false)
  end

  def valid_source_and_destination?(route)
    route[0].match?(LETTERS_ONLY_REGEX) && route[1].match?(LETTERS_ONLY_REGEX)
  end
  
  def valid_weigth?(route)
   route[2].match?(NUMBERS_ONLY_REGEX)
  end

  def valid_size?(route)
    route.size.eql? NUMBER_PARAMS_VALID_ROUTES
  end
end
