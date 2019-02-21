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

class Graph #main class for creating graph object
  #modify for weight
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

  def dfs(start_vertex)
  end

  def has_cycle?()
  end

  def kruskals_spanning_tree_algorithm()
    #stop condition is number of vertices - 1
    stop_condition = @vertices.size - 1
    weight = 0
    edges_list = []
    @vertices.each do |v|
      temp = v.edges.head
      until temp == nil
        current = [[v.value, temp.value].sort, temp.weight].flatten
        edges_list << current if !edges_list.include?(current) 
        temp = temp.link
      end
    end
    edges_list.sort_by! {|e| e[2]}
    spanning_list = []
    unions = DisjoinSet.new(@vertices)
    
    edges_list.each do |edge|
      if !unions.connected?(edge[0], edge[1])
        unions.union(edge[0], edge[1])
        spanning_list << edge
        weight += edge[2]
      end
    end
    weight
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
p x.kruskals_spanning_tree_algorithm()
