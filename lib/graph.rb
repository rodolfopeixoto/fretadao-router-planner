require 'dijkstra'
class Graph
  attr_reader :graph, :graph_paths,
              :source, :nodes, :previous,
              :distance, :path, :total_distance

  INFINITY = 999_999_999_999_999_999_999_999_999_999_999_999

  def initialize
    @graph = {}
    @nodes = []
    @source = source
    @path = []
    @graph_paths = []
    @distance = {}
    @previous = {}
  end

  def connect(source, destination, weight)
    if !graph.key?(source)
      graph[source] = { destination => weight }
    else
      graph[source][destination] = weight
    end
    nodes.push(source) unless nodes.include?(source)
  end

  def add_edge(source, destination, weight)
    connect(source, destination, weight)
    connect(destination, source, weight)
  end

  def find_path(destination_node)
    find_path(previous[destination_node]) if previous[destination_node] != -1
    path.push(destination_node)
  end

  def shortest_path(source, destination_finaly)
    dijkstra = Dijkstra.new(nodes, source, graph, distance, previous)
    dijkstra.call
    create_destionations(destination_finaly)
  end

  def create_destionations(destination_finaly)
    find_path(destination_finaly)

     @total_distance = distance[destination_finaly] if distance[destination_finaly] != INFINITY
     @total_distance = 'no path' if distance[destination_finaly].eql? INFINITY

     graph_paths.push("#{path.join(' ')} #{@total_distance}")
  end
end
