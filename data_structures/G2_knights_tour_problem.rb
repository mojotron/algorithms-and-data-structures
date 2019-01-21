require_relative "test.rb"

class Graph
  #class Vertex
  #  attr_accessor :value, :edges, :id
  #  def initialize(value)
  #    @value = value
  #    @id = nil
  #    @edges = LinkedList.new()
  #  end
  #end

  def print_board()
    a = (@vertices.size ** 0.5).floor
    i = 0
    a.times do
      (i...i + a).each do |x|
        print "#{@vertices[x].value}"
      end
      puts
      i += a
    end
  end
  def print_graph()
    @vertices.each do |vertex|
      puts "#{vertex.value}{#{vertex.edges.get_list}}"
    end
  end

  def depth_traversal(start_vertex)
    list = Array.new()
    visited = Array.new()
    stack = Array.new()
    stack << search_vertex(start_vertex)
    until stack.empty?
      temp_vertex = stack.pop()
      list << temp_vertex.value if !visited.include?(temp_vertex.value)
      visited << temp_vertex.value
      temp_node = temp_vertex.edges.head
      until temp_node == nil
        x = search_vertex(temp_node.value)
        stack << x if !visited.include?(temp_node.value)
        temp_node = temp_node.link
      end
    end
    list
  end
end

def knight_legal_moves(graph)
  knight_moves = [[-1,-2],[1,-2],[-2,-1],[2,-1],[-2,1],[2,1],[-1,2],[1,2]]
  graph.vertices.each do |v|
    x = v.value[0]
    y = v.value[1]
    knight_moves.each do |move|
      a = move[0]
      b = move[1]
      temp_vertex = [x + a, y + b]
      if graph.containes?(temp_vertex)
        graph.add_edge(v.value, temp_vertex)
      end
    end
  end
end

def onboard_position()
end

def knight_tour_graph(board_size)
  board = Graph.new()
  board_size.times do |row|
    board_size.times do |col|
      board.add_vertex([row, col])
    end
  end
  board
end






x = knight_tour_graph(8)
#x.print_board()
knight_legal_moves(x)
#x.print_graph()
p x.depth_traversal([2,2])