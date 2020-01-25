require 'graph'

class SearchRouteService < ApplicationService
  attr_reader :map,
              :source,
              :destination,
              :amount_liter,
              :autonomy_km,
              :graph

  def initialize(options = {})
    @map = options.fetch(:map)
    @source = options.fetch(:source)
    @destination = options.fetch(:destination)
    @autonomy_km = options.fetch(:autonomy_km)
    @amount_liter = options.fetch(:amount_liter)
    @graph = Graph.new
  end

  def call
    map = search_map
    return raise 'Map not found' unless valid_map?(map)

    create_graph(map)
    min_between_source_and_destination
    total_distance = graph.total_distance
    routes_result = graph.path.join(' ').upcase
    cost = CalculatorCostRouteService.call(total_distance, autonomy_km, amount_liter)
    params_formatted(routes_result, cost)
  end

  private

  def valid_map?(map)
    return false unless map.present?

    true
  end

  def search_map
    LogisticMesh.find_by(map: map)
  end

  def create_graph(map)
    routes = map.routes
    routes.each do |route|
      route_splited = route.split(' ')
      source = route_splited[0]
      destination = route_splited[1]
      weight = route_splited[2].to_i
      graph.add_edge source, destination, weight
    end
  end

  def min_between_source_and_destination
    graph.shortest_path(source, destination)
  end

  def params_formatted(routes_result, cost)
    {
      routes: routes_result,
      cost: cost
    }
  end
end
