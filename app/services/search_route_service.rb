require 'graph'

class SearchRouteService < ApplicationService
  attr_reader :map,
              :source,
              :destination,
              :amount_liter,
              :autonomy_km,
              :graph

  def initialize(map, source, destination, autonomy_km, amount_liter)
    @map = map
    @source = source
    @destination = destination
    @autonomy_km = autonomy_km
    @amount_liter = amount_liter
    @graph = Graph.new
  end

  def call
    create_graph
    graph.shortest_path(source, destination)
    total_distance = graph.total_distance
    routes_result = graph.path.join(' ').upcase
    cost = CalculatorCostRouteService.call(total_distance, autonomy_km, amount_liter)
    params_formatted(routes_result, cost)
  end

  private

  def search_map
    LogisticMesh.find_by(map: map)
  end

  def create_graph
    routes = search_map.routes
    routes.each do |route|
      route_splited = route.split(' ')
      source = route_splited[0]
      destination = route_splited[1]
      weight = route_splited[2].to_i
      graph.add_edge source, destination, weight
    end
  end

  def params_formatted(routes_result, cost)
    {
      routes: routes_result,
      cost: cost
    }
  end
end
