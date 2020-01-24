class SearchRouteService < ApplicationService

  attr_reader :map,
              :source,
              :destination,
              :amount_liter,
              :autonomy_km

  def initialize(map, source, destination, autonomy_km, amount_liter)
    @map = map
    @source = source
    @destination = destination
    @autonomy_km = autonomy_km
    @amount_liter
  end

  def call
    routes = search_map.routes
    create_graph(routes)
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

  def create_graph(routes)
    graph = Graph.new
    routes.each do |route|
      source = route[0]
      destination = route[1]
      weight = route[2]
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
