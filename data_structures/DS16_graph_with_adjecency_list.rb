class LinkedList #helper class for representing list of edges of single vertex
  class Node #LL helper class for representing single edge
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

  def list_size()
    temp_node = @head
    size = 0
    until temp_node == nil
      size += 1
      temp_node = temp_node.link
    end
    size
  end

  def list_contains?(value)
    temp_node = @head
    until temp_node == nil
      return true if temp_node.value == value
      temp_node = temp_node.link
    end
    false
  end

  def get_list()
    container = Array.new()
    temp_node = @head
    until temp_node == nil
      container << temp_node.value
      temp_node = temp_node.link
    end
    container
  end

  def append(value) #append node to end of list in constant time O(1), using tail pointer
    new_node = Node.new(value)
    if @head == nil
      @head = new_node
      @tail = new_node
      return
    else
      @tail.link = new_node
      @tail = @tail.link
    end
  end

  def delete(value) #delete node in linear time O(n)
    return nil if !list_contains?(value)
    if @head.value == value
      return @head = @tail = nil if @head == @tail #graph will always have unique values
      return @head = @head.link
    end
    temp_node = @head.link
    prev_node = @head
    until temp_node == nil
      if temp_node.value == value
        prev_node.link = temp_node.link
        @tail = prev_node if @tail.value == value
        return
      end
      temp_node = temp_node.link
      prev_node = prev_node.link
    end
  end
end

class Graph #main class for creating graph object
  class Vertex #helper class for representing elements in the graph
    #vertex has 2 parts, value(key, payload) and list of edges(connections with other vertices)
    attr_accessor :value, :edges 
    def initialize(value)
      @value = value
      @edges = LinkedList.new()
    end
  end
  
  attr_accessor :vertices
  def initialize()
    @vertices = Array.new() #graph is collection of vertices
  end

  def print_graph()#print all vertices with edges
    @vertices.each { |vertex| puts "[#{vertex.value}]{#{vertex.edges.get_list.join(',')}}" }
  end

  def contains_vertex?(value)
    @vertices.each { |vertex| return true if vertex.value == value }
    false
  end

  def search_vertex(value)
    @vertices.each { |vertex| return vertex if vertex.value == value }
    nil
  end

  def add_vertex(value)
    return nil if contains_vertex?(value)
    @vertices << Vertex.new(value)
  end

  def connected?(vertex_1, vertex_2)
    search_vertex(vertex_1).edges.list_contains?(vertex_2)
  end

  def add_edge(vertex_1, vertex_2)
    vertex_a = search_vertex(vertex_1)
    return nil if vertex_a == nil
    vertex_b = search_vertex(vertex_2)
    return nil if vertex_b == nil
    return nil if connected?(vertex_1, vertex_2)
    vertex_a.edges.append(vertex_b.value)
  end

  def delete_vertex(value)
    temp_vertex = search_vertex(value)
    return nil if temp_vertex == nil
    @vertices.delete(temp_vertex) #delete vertex from list
    @vertices.each do |vertex| #delete edges to deletet vertex from rest of vertices
      vertex.edges.delete(value) if vertex.edges.list_contains?(value)  
    end
    temp_vertex.value
  end

  def delete_edge(vertex_1, vertex_2)
    return nil if !connected?(vertex_1, vertex_2)
    search_vertex(vertex_1).edges.delete(vertex_2)
  end
  #graph traversal
  def depth_first_traversal(start_vertex)#using stack
    visited = Array.new()
    stack = Array.new()
    stack << search_vertex(start_vertex)
    until stack.empty?
      temp_vertex = stack.pop()
      visited << temp_vertex.value if !visited.include?(temp_vertex.value)
      vertex_edges = temp_vertex.edges.head
      temp_stack = Array.new() #for restack, so output is same as in recursion
      until vertex_edges == nil
        temp_stack << search_vertex(vertex_edges.value) if !visited.include?(vertex_edges.value)
        vertex_edges = vertex_edges.link
      end
      until temp_stack.empty?
        stack << temp_stack.pop()
      end
    end
    visited
  end

  def depth_first_recursive(start_vertex, visited = [])#using recusion, without stack DS
    temp_vertex = search_vertex(start_vertex)
    visited << temp_vertex.value if !visited.include?(temp_vertex.value)
    vertex_edges = temp_vertex.edges.head
    until vertex_edges == nil
      depth_first_recursive(vertex_edges.value, visited) if !visited.include?(vertex_edges.value)
      vertex_edges = vertex_edges.link
    end
    visited
  end

  def bradth_first_traversal(start_vertex) #using queue
    visited = Array.new()
    queue = Array.new()
    queue << search_vertex(start_vertex)
    until queue.empty?
      temp_vertex = queue.shift()
      visited << temp_vertex.value if !visited.include?(temp_vertex.value)
      vertex_edges = temp_vertex.edges.head
      until vertex_edges == nil
        queue << search_vertex(vertex_edges.value) if !visited.include?(vertex_edges.value)
        vertex_edges = vertex_edges.link
      end
    end
    visited
  end

  def bradth_first_recursive(start_vertex, queue = [], visited = [])
    temp_vertex = search_vertex(start_vertex)
    return if start_vertex == nil
    visited << temp_vertex.value if !visited.include?(temp_vertex.value)
    vertex_edges = temp_vertex.edges.head
    until vertex_edges == nil
      queue.push(vertex_edges.value) if !visited.include?(vertex_edges.value)
      vertex_edges = vertex_edges.link
    end
    bradth_first_recursive(queue.shift(), queue, visited)
    visited
  end

end
=begin
x = Graph.new()
x.add_vertex('S')
x.add_vertex('A')
x.add_vertex('B')
x.add_vertex('C')
x.add_vertex('D')
x.add_vertex('E')
x.add_vertex('F')
x.add_vertex('G')
x.add_vertex('S')
x.add_edge('S', 'A')
x.add_edge('A', 'S')
x.add_edge('S', 'B')
x.add_edge('B', 'S')
x.add_edge('S', 'C')
x.add_edge('C', 'S')
x.add_edge('A', 'D')
x.add_edge('D', 'A')
x.add_edge('B', 'E')
x.add_edge('E', 'B')
x.add_edge('C', 'F')
x.add_edge('F', 'C')
x.add_edge('D', 'G')
x.add_edge('G', 'D')
x.add_edge('E', 'G')
x.add_edge('G', 'E')
x.add_edge('F', 'G')
x.add_edge('G', 'F')
x.add_edge('F', 'C')
x.add_edge('F', 'C')
x.add_edge('F', 'C')

x.print_graph()
p x.depth_first_traversal('S')
p x.depth_first_recursive('S')
p x.bradth_first_traversal('S')
p x.bradth_first_recursive('S')
=end
