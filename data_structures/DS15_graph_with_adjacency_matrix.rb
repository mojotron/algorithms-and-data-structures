class Graph

  class Vertex
    attr_accessor :value, :edges
    def initialize(value)
      @value = value
      @edges = Array.new()
    end
  end

  attr_accessor :matrix
  def initialize()
    @matrix = Array.new()
  end

  def print_graph()
    print "\s\s\s"
    @matrix.each do |vertex|
      print vertex.value + "\s\s"
    end
    puts
    @matrix.each do |vertex|
      puts "#{vertex.value} #{vertex.edges}"
    end
  end

  def search_vertex(value)
    @matrix.each do |vertex|
      return vertex if value == vertex.value
    end
    nil
  end

  def search_vertex_index(value)
    @matrix.each_with_index do |vertex, index|
      return index if value == vertex.value
    end
    nil
  end

  def contains_vertex?(value)
    @matrix.each do |vertex|
      return true if value == vertex.value
    end
    false
  end

  def add_vertex(value)
    @matrix << Vertex.new(value)
    @matrix.each do |vertex|
      until vertex.edges.size == @matrix.size
        vertex.edges << 0
      end
    end
  end

  def add_edge(vertex_1, vertex_2)
    x = search_vertex_index(vertex_1)
    y = search_vertex_index(vertex_2)
    return if x == nil || y == nil
    @matrix[x].edges[y] = 1
  end

  def delete_vertex(value)
    i = search_vertex_index(value)
    value = @matrix[i].value
    @matrix.delete_at(i)
    @matrix.each do |vertex|
      vertex.edges.delete_at(i)
    end
    value
  end

  def delete_edge(vertex_1, vertex_2)
    x = search_vertex_index(vertex_1)
    y = search_vertex_index(vertex_2)
    return if x == nil || y == nil
    @matrix[x].edges[y] = 0
  end

  def connected?(vertex_1, vertex_2)
    x = search_vertex_index(vertex_1)
    y = search_vertex_index(vertex_2)
    return false if x == nil || y == nil
    (@matrix[x].edges[y] == 1) ? true : false
  end
  #traversal
  def depth_first(vertex)
    visited = Array.new()
    stack = Array.new()
    stack.push(search_vertex(vertex))
    while !stack.empty?
      temp_vertex = stack.pop()
      print "#{temp_vertex.value} -> " if !visited.include?(temp_vertex.value)
      visited << temp_vertex.value

      temp_vertex.edges.each_with_index do |value, index|
        if value == 1
          stack << @matrix[index] if !visited.include?(@matrix[index].value)
        end
      end
    end
    puts
  end

  def bradth_first(vertex)
    visited = Array.new()
    queue = Array.new()
    queue.push(search_vertex(vertex))
    while !queue.empty?
      temp_vertex = queue.shift()
      print "#{temp_vertex.value} -> " if !visited.include?(temp_vertex.value)
      visited << temp_vertex.value
      
      temp_vertex.edges.each_with_index do |value, index|
        if value == 1
          queue << @matrix[index] if !visited.include?(@matrix[index].value)
        end
      end
    end
    puts
  end
end

x = Graph.new()
x.add_vertex('A')
x.add_vertex('B')
x.add_vertex('C')
x.add_vertex('D')


x.add_edge('A','B')
x.add_edge('A','C')
x.add_edge('A','D')

x.add_edge('B','A')
x.add_edge('B','C')
x.add_edge('B','D')

x.add_edge('C','A')
x.add_edge('C','B')
x.add_edge('C','D')

x.add_edge('D','A')
x.add_edge('D','B')
x.add_edge('D','C')

x.delete_edge('D','B')

x.print_graph()
x.depth_first('A')
x.bradth_first('A')