require_relative "test.rb"

class Graph
  class Vertex
    attr_accessor :value, :edges, :distance, :parent, :color, :visited
    def initialize(value)
      @value = value
      @edges = LinkedList.new()
      @distance = 0 #
      @parent = nil #
      @color = "white"
      @visited = false     
    end
  end

  def print_graph()
    @vertices.each do |vertex|
      puts "#{vertex.value}{#{vertex.edges.get_list}}"
    end
  end

  def print_board()
    rows = (@vertices.size ** 0.5).floor
    i = 0
    rows.times do
      (i...i+rows).each do |col|
        print "#{@vertices[col].value}"
      end
      puts
      i += rows
    end
  end

  def bfs(start_vertex, end_vertex)#probaj sa roditeljem i distancom
    visited = Array.new()
    queue = Array.new()
    queue << search_vertex(start_vertex)
    until queue.empty?
      temp_vertex = queue.shift()
      visited << temp_vertex.value if !visited.include?(temp_vertex.value)
      temp_edges = temp_vertex.edges.head
      until temp_edges == nil
        temp_node = search_vertex(temp_edges.value)
        if temp_node.visited == false
          temp_node.visited = true
          temp_node.parent = temp_vertex.value
          queue << temp_node
        end
        temp_edges = temp_edges.link
      end
    end
    visited
  end

  def dfs(start_vertex, end_vertex)
    visited = Array.new()
    stack = Array.new()
    stack << search_vertex(start_vertex)
    until stack.empty?
      temp_vertex = stack.pop()
      visited << temp_vertex.value if !visited.include?(temp_vertex.value)
      return if temp_vertex.value == end_vertex
      temp_edges = temp_vertex.edges.head
      until temp_edges == nil
        temp_node = search_vertex(temp_edges.value)
        if temp_node.visited == false
          temp_node.visited = true
          temp_node.parent = temp_vertex.value
          stack << temp_node
        end
        temp_edges = temp_edges.link
      end
    end
  end

  def traversal(start_vertex, end_vertex)
    d = []
    x = search_vertex(end_vertex)
    until x.value == start_vertex
      d << x.value
      x = search_vertex(x.parent)
    end
    d << x.value
    d.reverse
  end
end
######
def knight_tour_graph(board_size = 8)
  new_graph = Graph.new()
  board_size.times do |row|
    board_size.times do |col|
      new_graph.add_vertex([row, col])
    end
  end
  new_graph
end

def knights_leagal_moves(graph)
  legal_moves = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
  graph.vertices.each do |vertex|
    x = vertex.value[0]
    y = vertex.value[1]
    legal_moves.each do |move|
      a = move[0]
      b = move[1]
      temp_vertex = [x + a, y + b]
      graph.add_edge(vertex.value, temp_vertex) if graph.containes?(temp_vertex)
    end
  end
end

x = knight_tour_graph()
y = knight_tour_graph()
knights_leagal_moves(x)
knights_leagal_moves(y)
x.bfs([0,0],[7,7])
p x.traversal([0,0],[7,7])
y.dfs([0,0],[7,7])
p y.traversal([0,0],[7,7])