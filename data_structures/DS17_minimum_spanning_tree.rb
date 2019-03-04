require_relative "DS16_graph_with_adjecency_list.rb"
class LinkedList
  class Node
    attr_accessor :value, :link, :weight
    def initialize(value, weight = 0)
      @value = value
      @link = nil
      @weight = weight
    end
  end

  def get_list()
    container = Array.new()
    temp_node = @head
    until temp_node == nil
      container << [temp_node.value, temp_node.weight]
      temp_node = temp_node.link
    end
    container
  end

  def append(value, weight)
    new_node = Node.new(value, weight)
    if @head == nil
      @head = new_node
      @tail = new_node
      return
    else
      @tail.link = new_node
      @tail = @tail.link
    end
  end
end

class DisjoinSet
  attr_accessor :set 
  def initialize(vertices)
    @set = {}
    vertices.each_with_index { |vertex, id| @set[vertex.value] = id }
  end

  def find(value)
    @set[value]
  end

  def union(value_a, value_b)
    return nil if @set[value_a] == @set[value_b]
    a_id = find(value_a)
    b_id = find(value_b)
    @set.each { |value, id| @set[value] = a_id if id == b_id }
  end
end

class Graph
  class Vertex
    attr_accessor :value, :edges, :color, :distance, :parent
    def initialize(value)
      @value = value
      @edges = LinkedList.new()
      @distance = Float::INFINITY
      @parent = nil
    end
  end

  def print_graph()
    @vertices.each { |vertex| puts "[#{vertex.value}]>>#{vertex.edges.get_list}" }
  end

  def add_edge(vertex_1, vertex_2, weight)
    vertex_a = search_vertex(vertex_1)
    return nil if vertex_a == nil
    vertex_b = search_vertex(vertex_2)
    return nil if vertex_b == nil
    return nil if connected?(vertex_1, vertex_2)
    vertex_a.edges.append(vertex_b.value, weight)
  end

  #kruskal helper method
  def get_sorted_edges_by_weight(vertices)
    edges_list = []
    vertices.each do |vertex|
      temp_node = vertex.edges.head
      until temp_node == nil
        current = [[vertex.value, temp_node.value].sort, temp_node.weight].flatten
        edges_list << current if !edges_list.include?(current) #graph is undirected, every edge is double
        temp_node = temp_node.link
      end
    end
    edges_list.sort_by { |item| item[2] }
  end

  def kruskal_mst()
    weight = 0
    mst = []
    disjoin_set = DisjoinSet.new(@vertices)
    sorted_edges = get_sorted_edges_by_weight(@vertices)

    sorted_edges.each do |edge|
      if disjoin_set.find(edge[0]) != disjoin_set.find(edge[1])
        disjoin_set.union(edge[0], edge[1])
        mst << edge
        weight += edge[2]
      end
    end
    [weight, mst]
  end

  #prims helper methods
  def get_vertices(vertices)
    @vertices.map {|vertex| vertex }
  end

  def get_smallest_distance(vertices) #get vertex with smallest distance
    target_vertex = nil
    smallest_distance = Float::INFINITY
    vertices.each do |vertex|
      if vertex.distance < smallest_distance
        target_vertex = vertex
        smallest_distance = vertex.distance
      end
    end
    target_vertex
  end

  def get_edge_weight(vertex_1, vertex_2)
    temp_node = search_vertex(vertex_1).edges.head
    until temp_node == nil
      return temp_node.weight if temp_node.value == vertex_2
      temp_node = temp_node.link
    end
    nil
  end

  def get_total_weight(edges)
    edges.reduce(0) { |total, edge| total += edge[2] }
  end

  def prim_mst(start_vertex)
    mst = []
    @vertices.each do |vertex|
      vertex.parent = nil
      vertex.distance = Float::INFINITY
    end
    start = search_vertex(start_vertex)
    start.distance = 0
    queue = get_vertices(@vertices)
    until queue.empty?
      temp_vertex = queue.delete(get_smallest_distance(queue))
      if temp_vertex.parent != nil
        mst << [temp_vertex.parent, temp_vertex.value, get_edge_weight(temp_vertex.parent, temp_vertex.value)]
      end
      temp_node = temp_vertex.edges.head
      until temp_node == nil
        current_node = search_vertex(temp_node.value)
        if temp_node.weight < current_node.distance
          current_node.parent = temp_vertex.value
          current_node.distance = temp_node.weight
        end
        temp_node = temp_node.link
      end
    end
    [get_total_weight(mst), mst]
  end

  #dijkstar helper
  def print_distances(vertices)
    vertices.each { |vertex| puts "#{vertex.value} - #{vertex.distance}" }
  end

  def dijkstra_shortest_path(start_vertex)
    @vertices.each do |vertex|
      vertex.parent = nil
      vertex.distance = Float::INFINITY
    end
    start = search_vertex(start_vertex)
    start.distance = 0
    queue = get_vertices(@vertices)
    until queue.empty?
      temp_vertex = queue.delete(get_smallest_distance(queue))
      temp_node = temp_vertex.edges.head
      until temp_node == nil
        new_distance = temp_vertex.distance + temp_node.weight
        current_node = search_vertex(temp_node.value)
        if new_distance < current_node.distance
          current_node.parent = temp_vertex.value
          current_node.distance = new_distance
        end
        temp_node = temp_node.link
      end
    end
    print_distances(@vertices)
  end

end

x = Graph.new()
x.add_vertex('A')
x.add_vertex('B')
x.add_vertex('S')
x.add_vertex('T')
x.add_vertex('C')
x.add_vertex('D')
x.add_edge('A', 'B', 6)
x.add_edge('B', 'A', 6)
x.add_edge('A', 'S', 7)
x.add_edge('S', 'A', 7)
x.add_edge('A', 'C', 3)
x.add_edge('C', 'A', 3)
x.add_edge('B', 'T', 5)
x.add_edge('T', 'B', 5)
x.add_edge('B', 'D', 2)
x.add_edge('D', 'B', 2)
x.add_edge('B', 'C', 4)
x.add_edge('C', 'B', 4)
x.add_edge('S', 'C', 8)
x.add_edge('C', 'S', 8)
x.add_edge('C', 'D', 3)
x.add_edge('D', 'C', 3)
x.add_edge('D', 'T', 2)
x.add_edge('T', 'D', 2)

p x.kruskal_mst()
p x.prim_mst('T')
x.dijkstra_shortest_path('T')