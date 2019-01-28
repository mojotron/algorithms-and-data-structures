class Graph
  class Vertex
    attr_accessor :value, :edges
    def initialize(value)
      @value = value
      @edges = Array.new()
    end
  end

  attr_accessor :vertices
  def initialize()
    @vertices = Array.new()
  end

  def print_graph()
    print "\s" * 3
    @vertices.each { |vertex| print "#{vertex.value}\s\s"}
    puts
    @vertices.each do |vertex|
      puts "#{vertex.value} #{vertex.edges}"
    end
  end

  def contains?(value)
    @vertices.each do |vertex|
      return true if vertex.value == value
    end
    false
  end

  def search_vertex(value)
    @vertices.each { |vertex| return vertex if vertex.value == value}
    nil
  end

  def search_vertex_index(value)
    @vertices.each_with_index { |vertex, index| return index if vertex.value == value}
    nil
  end

  def add_vertex(value)
    return if contains?(value)
    @vertices.push(Vertex.new(value))
    @vertices.each do |vertex|
      until vertex.edges.size == @vertices.size
        vertex.edges.push(0)
      end
    end
  end

  def add_edge(vertex_1, vertex_2)
    vertex_a = search_vertex_index(vertex_1)
    return if vertex_a == nil
    vertex_b = search_vertex_index(vertex_2)
    return if vertex_b == nil
    @vertices[vertex_a].edges[vertex_b] = 1
  end

  def connected?(vertex_1, vertex_2)
    vertex_a = search_vertex_index(vertex_1)
    return false if vertex_a == nil
    vertex_b = search_vertex_index(vertex_2)
    return false if vertex_b == nil
    (@vertices[vertex_a].edges[vertex_b] == 1) ? true : false
  end

  def delete_vertex(value)
    return nil if !contains?(value)
    index = search_vertex_index(value)
    @vertices.delete_at(index)
    @vertices.each do |vertex|
      vertex.edges.delete_at(index)
    end
  end

  def delete_edge(vertex_1, vertex_2)
    vertex_a = search_vertex_index(vertex_1)
    return if vertex_a == nil
    vertex_b = search_vertex_index(vertex_2)
    return if vertex_b == nil
    @vertices[vertex_a].edges[vertex_b] = 0
  end

  def depth_first_traversal(start_vertex)
    visited = Array.new()
    stack = Array.new()
    stack.push(search_vertex(start_vertex))
    until stack.empty?
      temp_vertex = stack.pop()
      print "#{temp_vertex.value} -> " if !visited.include?(temp_vertex.value)
      visited.push(temp_vertex.value)
      temp_stack = Array.new()
      temp_vertex.edges.each_with_index do |edge, index|
        if edge == 1
          temp_stack.push(@vertices[index]) if !visited.include?(@vertices[index].value)
        end
      end
      until temp_stack.empty?
        stack.push(temp_stack.pop())
      end
    end
    puts
  end

  def level_first_traversal(start_vertex)
    visited = Array.new()
    queue = Array.new()
    queue.push(search_vertex(start_vertex))
    until queue.empty?
      temp_vertex = queue.shift()
      print "#{temp_vertex.value} -> " if !visited.include?(temp_vertex.value)
      visited.push(temp_vertex.value)
      temp_vertex.edges.each_with_index do |edge, index|
        if edge == 1
          queue.push(@vertices[index]) if !visited.include?(@vertices[index].value)
        end
      end
    end
    puts
  end
end

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
x.delete_edge('F','C')
x.print_graph()
x.depth_first_traversal('S')
x.level_first_traversal('S')
