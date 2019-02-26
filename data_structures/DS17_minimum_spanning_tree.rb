require_relative "DS16_graph_with_adjecency_list.rb"
#Modify LL class, for weighted graph
class LinkedList
  class Node 
    attr_accessor :value, :link, :weight #Note! Add weight
    def initialize(value, weight = 0) 
      @value = value
      @link = nil
      @weight = weight # Note! Add weight 
    end
  end

  def get_list()
    container = Array.new()
    temp_node = @head
    until temp_node == nil
      #Note! Return array, with edge and weight of edge
      container << [temp_node.value, temp_node.weight] 
      temp_node = temp_node.link
    end
    container
  end
  #Note! Add weight attribut to new edge
  def append(value, weight) #append node to end of list in constant time O(1), using tail pointer
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
  attr_accessor :parents
  def initialize(vertices)
    @parents = {}
    vertices.each_with_index do |vertex, id|
      @parents[vertex.value] = id
    end
  end

  def find(vertex)
    @parents[vertex]
  end

  def connected?(a, b)
    @parents[a] == @parents[b]
  end

  def union(a, b)
    return if connected?(a, b)
    a_id = find(a)
    b_id = find(b)

    @parents.each do |node, id|
      @parents[node] = a_id if id == b_id
    end
  end
end

class PriorityQueue
  attr_accessor :queue 
  def initialize()
    @queue = Hash.new()
  end

  def is_empty?
    @queue.empty?
  end

  def insert(value, priority)
    @queue[value] = priority
    sort_priority()
  end

  def get_top_priority()
    @queue.shift
  end

  def sort_priority()
    @queue = @queue.sort_by { |value, priority| priority}.to_h
  end
end

class Graph #main class for creating graph object
  #modify for weight
  class Vertex 
    attr_accessor :value, :edges, :color, :parent, :distance, :visited
    def initialize(value)
      @value = value #original vertex variable
      @edges = LinkedList.new() #original vertex variable
      #add for solution with colors & visited flag variable
      @color = 'white'
      @parent = nil
      @distance = 0
      @visited = false
    end
  end
  def print_graph()#print all vertices with edges
    @vertices.each { |vertex| puts "[#{vertex.value}]>>#{vertex.edges.get_list}" }
  end
  #modify for weight
  def add_edge(vertex_1, vertex_2, wight = 0)
    vertex_a = search_vertex(vertex_1)
    return nil if vertex_a == nil
    vertex_b = search_vertex(vertex_2)
    return nil if vertex_b == nil
    return nil if connected?(vertex_1, vertex_2)
    vertex_a.edges.append(vertex_b.value, wight)
  end

  def get_edges_sorted(vertices)
    edge_list = Array.new()
    vertices.each do |vertex|
      temp = vertex.edges.head
      until temp == nil
        current = [[vertex.value, temp.value].sort, temp.weight].flatten
        edge_list << current if !edge_list.include?(current)
        temp = temp.link
      end
    end
    edge_list.sort_by { |edge| edge[2] }
  end

  def kruskals_spanning_tree_algorithm()
    weight = 0
    edges_list = get_edges_sorted(@vertices)
    spanning_list = Array.new()
    unions = DisjoinSet.new(@vertices)

    edges_list.each do |edge|
      if !unions.connected?(edge[0], edge[1])
        unions.union(edge[0], edge[1])
        spanning_list << edge
        weight += edge[2]
      end
    end
    [weight, spanning_list]
  end

  def get_vertex_edges(vertex)
    container = []
    temp_node = vertex.edges.head
    until temp_node == nil
      container << [[vertex.value, temp_node.value].sort, temp_node.weight].flatten
      temp_node = temp_node.link
    end
    container.sort_by {|i| i[2]}
  end

  def get_vertices()
    container = []
    @vertices.each do |v|
      container << v
    end
    container
  end

  def get_smallest(queue)
    smallest = Float::INFINITY
    target = nil
    queue.each do |v|
      if v.distance < smallest
        smallest = v.distance
        target = v
      end
    end
    target

  end

  def prims_spanning_tree_algorithm(start_vertex)
    mst = []
    @vertices.each do |v|
      v.parent = nil
      v.distance = Float::INFINITY
    end
    start = search_vertex(start_vertex)
    start.distance = 0
    queue = get_vertices()
    until queue.empty?
      temp_vertex = queue.delete(get_smallest(queue))
      ###
      if temp_vertex.parent != nil
        mst << [temp_vertex.parent, temp_vertex.value]
      end
      ###
      temp_edges = temp_vertex.edges.head
      until temp_edges == nil
        current_vertex = search_vertex(temp_edges.value)
        if temp_edges.weight < current_vertex.distance
          current_vertex.parent = temp_vertex.value
          current_vertex.distance = temp_edges.weight
        end
        temp_edges = temp_edges.link
      end
     
    end
    mst
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
#x.print_graph()
#p x.kruskals_spanning_tree_algorithm()
p x.prims_spanning_tree_algorithm('A')
