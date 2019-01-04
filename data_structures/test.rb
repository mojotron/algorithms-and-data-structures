require_relative "DS1_linked_list.rb"
class Graph
  class Vertex
    attr_accessor :value, :edges
    def initialize(value)
      @value = value
      @edges = LinkedList.new()
    end
  end

  attr_accessor :vertices
  def initialize()
    @vertices = Array.new()
  end

  def print_graph()
    @vertices.each do |i|
      print"[#{i.value}] => " 
      temp_node = i.edges.head
      until temp_node == nil
        print temp_node.value + ' -> '
        temp_node = temp_node.link
      end
      puts "nil"
    end
  end
  
  def add_vertex(value)
    return nil if find_vertex(value) #check if value already in list
    node_new = Vertex.new(value)
    @vertices << node_new
  end

  def find_vertex(value)
    i = 0
    while i < @vertices.size
      return @vertices[i] if @vertices[i].value == value
      i += 1
    end
    nil
  end

  def insert_edge(vertex_1, vertex_2)
    v1 = find_vertex(vertex_1)
    return if v1 == nil
    v2 = find_vertex(vertex_2)
    return if v2 == nil
    return nil if v1.edges.search(v2.value)
    v1.edges.push(v2.value)
  end
end

x = Graph.new()
x.add_vertex('A')
x.add_vertex('B')
x.add_vertex('C')
x.add_vertex('D')
x.add_vertex('E')
x.add_vertex('F')
x.add_vertex('G')
x.add_vertex('H')
x.insert_edge('A', 'B')
x.insert_edge('A', 'C')
x.insert_edge('A', 'D')
x.insert_edge('B', 'A')
x.insert_edge('B', 'E')
x.insert_edge('B', 'F')
x.insert_edge('A', 'B')
x.insert_edge('C', 'A')
x.insert_edge('C', 'G')
x.insert_edge('D', 'A')
x.insert_edge('D', 'H')
x.insert_edge('E', 'B')
x.insert_edge('E', 'H')
x.insert_edge('F', 'B')
x.insert_edge('F', 'H')
x.insert_edge('G', 'C')
x.insert_edge('G', 'H')
x.insert_edge('H', 'D')
x.insert_edge('H', 'E')
x.insert_edge('H', 'F')
x.insert_edge('H', 'G')
x.print_graph()