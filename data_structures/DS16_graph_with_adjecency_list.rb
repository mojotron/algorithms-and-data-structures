class LinkedList
  class Node
    attr_accessor :value, :link
    def initialize(value)
      @value = value
      @link = nil
    end
  end

  attr_accessor :head, :tail
  def initialize()
    @head = nil
    @tail = nil
  end

  def print_list()
    container = Array.new()
    temp_node = @head
    until temp_node == nil
      container << temp_node.value
      temp_node = temp_node.link
    end
    container
  end

  def list_contains?(value)
    temp_node = @head
    until temp_node == nil
      return true if temp_node.value == value
      temp_node = temp_node.link
    end
    false
  end

  def push(value) #append node with O(1) time complexity
    new_node = Node.new(value)
    if @head == nil
      @head = new_node
      @tail = new_node
    else
      @tail.link = new_node
      @tail = @tail.link
    end
  end

  def delete(value)
    return nil if !list_contains?(value)
    return @head = @head.link if @head.value == value
    
    temp_node = @head.link
    prev_node = @head
    until temp_node == nil
      if temp_node.value == value
        prev_node.link = temp_node.link 
        @tail = prev_node if @tail.value == value #!!!!
        return
      end
      temp_node = temp_node.link
      prev_node = prev_node.link
    end
  end
end

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

  def contain_vertex?(value)
    i = 0
    while i < @vertices.size
      return true if value == @vertices[i].value
      i += 1
    end
    false
  end

  def search_vertex(value)
    i = 0
    while i < @vertices.size
      return @vertices[i] if value == @vertices[i].value
      i += 1
    end
    nil
  end

  def print_graph()
    @vertices.each do |vertex|
      puts "[#{vertex.value}]{#{vertex.edges.print_list.join(',')}}"
    end
  end

  def add_vertex(value)
    if contain_vertex?(value)
      puts "Name #{value} already in the graph!"
      return nil
    end
    @vertices << Vertex.new(value)
  end

  def add_edge(vertex_1, vertex_2, weight = 0)
    vertex_a = search_vertex(vertex_1)
    return if vertex_a == nil
    vertex_b = search_vertex(vertex_2)
    return if vertex_b == nil
    #check if edge already set
    return nil if vertex_a.edges.list_contains?(vertex_b.value)
    vertex_a.edges.push(vertex_b.value)
  end

  def connected?(vertex_1, vertex_2)
    temp_vertex = search_vertex(vertex_1)
    return false if temp_vertex == nil
    temp_vertex.edges.list_contains?(vertex_2)
  end

  def delete_vertex(value)
    temp_vertex = search_vertex(value)
    @vertices.delete(temp_vertex)
    @vertices.each do |vertex|
      if vertex.edges.list_contains?(value)
        vertex.edges.delete(value)
      end
    end
  end

  def delete_edge(vertex_1, vertex_2)
    return if !connected?(vertex_1, vertex_2)
    temp_vertex = search_vertex(vertex_1)
    temp_vertex.edges.delete(vertex_2)
  end

  def depth_first_traversal(vertex = @vertices[0])
    queue = Array.new()
    queue.push(vertex)
    while !queue.empty?
    end
  end

  def bradth_first_traversal()
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
x.add_edge('A', 'B')
x.add_edge('A', 'C')
x.add_edge('A', 'D')
x.add_edge('B', 'A')
x.add_edge('B', 'E')
x.add_edge('B', 'F')
x.add_edge('A', 'B')
x.add_edge('C', 'A')
x.add_edge('C', 'G')
x.add_edge('D', 'A')
x.add_edge('D', 'H')
x.add_edge('E', 'B')
x.add_edge('E', 'H')
x.add_edge('F', 'B')
x.add_edge('F', 'H')
x.add_edge('G', 'C')
x.add_edge('G', 'H')
x.add_edge('H', 'D')
x.add_edge('H', 'E')
x.add_edge('H', 'F')
x.add_edge('H', 'G')
x.delete_vertex('A')
x.delete_vertex('H')
x.print_graph()


=begin
x = LinkedList.new()
x.push('A')
x.push('B')
x.push('C')
x.push('D')
x.push('E')
x.push('F')
x.delete('A')
p x.print_list()
p x.head
p x.tail
=end