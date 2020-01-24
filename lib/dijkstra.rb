class Dijkstra

  attr_accessor :distance, :previous, :source, :nodes, :graph

  INFINITY = 999_999_999_999_999_999_999_999_999_999_999_999

  def initialize(nodes, source, graph, distance, previous)
    @nodes = nodes
    @source = source
    @distance = distance
    @graph = graph
    @previous = previous
  end

  def call
    initialize_nodes
    initialize_distance_source_to_source
    unvisited_nodes = initialize_unvisited_nodes
    check_unvisted_nodes(unvisited_nodes)
  end

  def initialize_distance_source_to_source
    distance[source] = 0
  end

  def initialize_nodes
    nodes.each do |node|
      distance[node] = INFINITY
      previous[node] = -1
    end
  end

  def initialize_unvisited_nodes
    nodes.compact
  end

  def check_unvisted_nodes(unvisited_nodes)
    until unvisited_nodes.empty?
      current_node = nil

      unvisited_nodes.each do |min|
        current_node = min if relax_edges?(current_node, min)
      end

      break if distance_visited_eql_infinity?(current_node)

      unvisited_nodes -= [current_node]

      graph[current_node].keys.each do |vertex|
        sum_distances = distance[current_node] + graph[current_node][vertex]
        update_distance_previous(vertex, sum_distances, current_node)  if sum_distances < distance[vertex]
      end

    end
  end

  def relax_edges?(current_node, min)
    !current_node || (distance[min] && (distance[min] < distance[current_node]))
  end

  def distance_visited_eql_infinity?(current_node)
    distance[current_node].eql? INFINITY
  end

  def update_distance_previous(vertex, sum_distances, current_node)
    distance[vertex] = sum_distances
    previous[vertex] = current_node
  end
end
