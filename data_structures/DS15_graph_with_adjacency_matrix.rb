class Graph #main class for representing graph, graph is adjacency matrix,
  #matrix will be represented as 2D array
  class Vertex #helper class for representing unique element in the graph
    attr_accessor :value, :edges
    #vertex has 2 parts, value(key, payload) and list of edges(connections with other vertices)
    def initialize(value)
      @value = value
      @edges = Array.new() #edges are inner array
    end
  end

  attr_accessor :matrix
  def initialize()
    @matrix = Array.new() #outer array in matrix
  end

  def print_graph()
    print "\s\s\s" #space for frist column
    @matrix.each { |col_name| print "#{col_name.value}\s\s"} #print name of columns
    puts #move to new line and print all vertices(row name) and edges, list of conrctions
    @matrix.each {|row| puts "#{row.value}\s#{row.edges}"}
  end

  def contains_vertex?(value)
    @matrix.each { |vertex| return true if vertex.value == value}
    false
  end

  def search_vertex(value)
    @matrix.each { |vertex| return vertex if vertex.value == value}
    nil
  end

  def search_vertex_index(value)
    @matrix.each_with_index { |vertex, index| return index if vertex.value == value}
    nil
  end

  def add_vertex(value)
    return nil if contains_vertex?(value)
    @matrix << Vertex.new(value)
    @matrix.each do |vertex|
      until vertex.edges.size == @matrix.size
        vertex.edges << 0
      end
    end
  end

  def connected?(vertex_1, vertex_2)
    index_a = search_vertex_index(vertex_1)
    return nil if index_a == nil
    index_b = search_vertex_index(vertex_2)
    return nil if index_b == nil
    @matrix[index_a].edges[index_b] == 1 ? true : false
  end

  def add_edge(vertex_1, vertex_2)
    index_a = search_vertex_index(vertex_1)
    return nil if index_a == nil
    index_b = search_vertex_index(vertex_2)
    return nil if index_b == nil
    @matrix[index_a].edges[index_b] = 1
  end

  def delete_vertex(value)
    return nil if !contains_vertex?(value)
    index = search_vertex_index(value)
    @matrix.delete_at(index)
    @matrix.each { |vertex| vertex.edges.delete_at(index) }
  end

  def delete_edge(vertex_1, vertex_2)
    index_a = search_vertex_index(vertex_1)
    return nil if index_a == nil
    index_b = search_vertex_index(vertex_2)
    return nil if index_b == nil
    @matrix[index_a].edges[index_b] = 0
  end
  #graph traversal
  def depth_first_traversal(start_vertex)#using stack
    visited = Array.new()
    stack = Array.new()
    stack << search_vertex(start_vertex)
    until stack.empty?
      temp_vertex = stack.pop()
      visited << temp_vertex.value if !visited.include?(temp_vertex.value)
      temp_stack = Array.new()
      temp_vertex.edges.each_with_index do |edge, index|
        temp_stack << @matrix[index] if !visited.include?(@matrix[index].value) if edge == 1
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
    temp_vertex.edges.each_with_index do |edge, index|
      if edge == 1
        depth_first_recursive(@matrix[index].value, visited) if !visited.include?(@matrix[index].value)
      end
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
      temp_vertex.edges.each_with_index do |edge, index|
        if edge == 1
          queue << @matrix[index] if !visited.include?(@matrix[index].value)
        end
      end
    end
    visited
  end

  def bradth_first_recursive(start_vertex, queue = [], visited = [])
    temp_vertex = search_vertex(start_vertex)
    return if temp_vertex == nil
    visited << temp_vertex.value if !visited.include?(temp_vertex.value)
    temp_vertex.edges.each_with_index do |edge, index|
      if edge == 1
        queue << @matrix[index].value if !visited.include?(@matrix[index].value)
      end #NOTE insert @matrix[index].value in queue
    end
    bradth_first_recursive(queue.shift(), queue, visited)
    visited
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
p x.depth_first_traversal('S')
p x.depth_first_recursive('S')
p x.bradth_first_traversal('S')
p x.bradth_first_recursive('S')



=begin
x.delete_edge('D','B')
x.print_graph()
x.depth_first('A')
x.bradth_first('A')
=end