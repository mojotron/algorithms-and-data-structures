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

  def list_contains?(value)
    return false if @head == nil
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

  def append(value)
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
    return nil if @head == nil #list is empty
    if @head.value == value #delete first element
      return @head = @tail = nil if @head == @tail
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
    @vertices.each do |vertex|
      puts "[#{vertex.value}]{#{vertex.edges.get_list.join(',')}}"
    end
  end

  def containes?(value)
    @vertices.each do |vertex|
      return true if vertex.value == value
    end
    false
  end

  def search_vertex(value)
    @vertices.each { |vertex| return vertex if vertex.value == value }
  end

  def add_vertex(value)
    return nil if containes?(value)
    @vertices << Vertex.new(value)
  end

  def add_edge(vertex_1, vertex_2)
    vertex_a = search_vertex(vertex_1)
    return if vertex_a == nil
    vertex_b = search_vertex(vertex_2)
    return if vertex_b == nil
    return if vertex_a.edges.list_contains?(vertex_b.value)
    vertex_a.edges.append(vertex_b.value)
  end

  def connected?(vertex_1, vertex_2)
    search_vertex(vertex_1).edges.list_contains?(vertex_2)
  end

  def delete_vertex(value)
    temp_vertex = search_vertex(value)
    return nil if temp_vertex == nil
    @vertices.delete(temp_vertex)
    @vertices.each do |vertex|
      vertex.edges.delete(value) if vertex.edges.list_contains?(value)
    end
    value
  end

  def delete_edge(vertex_1, vertex_2)
    return if !connected?(vertex_1, vertex_2)
    search_vertex(vertex_1).edges.delete(vertex_2)
  end

  def depth_traversal(start_vertex)
    visited = Array.new()
    stack = Array.new()
    stack.push(search_vertex(start_vertex))
    until stack.empty?
      temp_vertex = stack.pop()
      print "#{temp_vertex.value} -> " if !visited.include?(temp_vertex.value)
      visited.push(temp_vertex.value)
      temp_node = temp_vertex.edges.head
      temp_stack = Array.new()
      until temp_node == nil
        temp_stack.push(search_vertex(temp_node.value)) if !visited.include?(temp_node.value)
        temp_node = temp_node.link
      end
      until temp_stack.empty? #restack change order of elements
        stack.push(temp_stack.pop())
      end
    end
    puts
  end

  def depth_traversal_recursion(start_vertex, visited = [])
    temp_vertex = search_vertex(start_vertex)
    print "#{temp_vertex.value} -> "
    visited.push(temp_vertex.value)
    temp_node = temp_vertex.edges.head
    until temp_node == nil
      depth_traversal_recursion(temp_node.value, visited) if !visited.include?(temp_node.value)
      temp_node = temp_node.link
    end
  end

  def level_traversal(start_vertex)
    visited = Array.new()
    queue = Array.new()
    queue.push(search_vertex(start_vertex))
    until queue.empty?
      temp_vertex = queue.shift()
      print "#{temp_vertex.value} -> " if !visited.include?(temp_vertex.value)
      visited.push(temp_vertex.value)
      temp_node = temp_vertex.edges.head
      until temp_node == nil
        queue.push(search_vertex(temp_node.value)) if !visited.include?(temp_node.value)
        temp_node = temp_node.link
      end
    end
    puts
  end

  def level_traversal_recursion(start_vertex, queue = [], visited = [])
    temp_vertex = search_vertex(start_vertex)
    return if start_vertex == nil
    print "#{temp_vertex.value} -> " if !visited.include?(temp_vertex.value)
    visited.push(temp_vertex.value)
    temp_node = temp_vertex.edges.head
    until temp_node == nil
      queue.push(temp_node.value) if !visited.include?(temp_node.value)
      temp_node = temp_node.link
    end
    level_traversal_recursion(queue.shift(), queue, visited)
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
x.depth_traversal('S')
x.depth_traversal_recursion('S')
puts
x.level_traversal('S')
x.level_traversal_recursion('S')
puts
=end