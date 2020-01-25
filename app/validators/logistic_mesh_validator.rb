class LogisticMeshValidator < ApplicationValidator
  attr_reader :map, :routes

  LETTERS_ONLY_REGEX = /[a-zA-Z]/.freeze
  NUMBERS_ONLY_REGEX = /[0-9]/.freeze
  NUMBER_PARAMS_VALID_ROUTES = 3

  def initialize(map, routes)
    @map = map
    @routes = routes
  end

  def call
    return false if valid_routes.include?(false)

    true
  end

  def valid_routes
    return false unless routes.is_a?(Array)

    routes.map do |route|
      false unless valid_params?(route)
    end
  end

  def valid_params?(route)
    route_array = route.split(' ')
    valid = valid_source_and_destination?(route_array) && valid_weigth?(route_array)
    valid = valid && valid_size?(route_array) && valid_map?
    valid && route_is_not_empty?(route)
  end

  def route_is_not_empty?(route)
    !route.empty?
  end

  def valid_map?
    !map.empty? && map.match?(LETTERS_ONLY_REGEX)
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
