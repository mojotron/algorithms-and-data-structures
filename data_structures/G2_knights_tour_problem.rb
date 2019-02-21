require_relative "DS16_graph_with_adjecency_list.rb"

class Graph #modify class graph for knights tour problem
  class Vertex 
    attr_accessor :value, :edges, :color, :parent, :distance, :finish
    def initialize(value)
      @value = value #original vertex variable
      @edges = LinkedList.new() #original vertex variable
      #add for solution with colors & visited flag variable
      @color = 'white'
      @parent = nil
      @distance = 0
      @finish = 0
    end
  end

  attr_accessor :vertices, :times
  def initialize()
    @vertices = Array.new() #graph is collection of vertices
    @times = 0
  end

  def print_chess_board() #visual representation of chess board
    row_size = (@vertices.size ** 0.5).floor
    i = 0
    row_size.times do
      (i...i + row_size).each { |x| print @vertices[x].value }
      i += row_size
      puts
    end
  end

  def print_graph() #modify print, graph value is array so isted printing array in array
    @vertices.each { |vertex| puts "#{vertex.value}>>#{vertex.edges.get_list}"}
  end

  

  def warnsdorffs_heuristic(start_vertex)
    #push the knight to visit edges around corners of the board first, doing this by
    #sorting edges for next move from lowest to highest edge count
    next_moves = search_vertex(start_vertex).edges.get_list
    #squares depending on position, have 2,3,4,6 or 8 possible next moves
    two, three, four, five, six, eight = [], [], [], [], [], []
    next_moves.each do |move| #sort moves in separate array an add them together
      temp = search_vertex(move)
      temp = temp.edges.list_size
      two << move if temp == 2 
      three << move if temp == 3
      four << move if temp == 4
      six << move if temp == 6
      eight << move if temp == 8
    end
    #revers, DFS use stack, this way last element is first in stack
    eight + six + four + three + two #revers, 
  end

  def dfs_x()
    @vertices.each do |vertex|
      vertex.color = 'white'
      vertex.parent = nil
    end
    @times = 0
    @vertices.each do |vertex|
      dfs_visit(vertex) if vertex.color == 'white'
    end
  end

  def dfs_visit(vertex)
    #print vertex.value
    print vertex.value
    @times += 1
    vertex.distance = @times
    vertex.color = 'gray'
    vertex.edges.get_list.each do |x|
      temp = search_vertex(x)
      if temp.color == 'white'
        temp.parent = vertex.value
        dfs_visit(temp)
      end
    end
    vertex.color = 'black'
    @times += 1
    vertex.finish = @times
  end

  def traversal(end_vertex)
    path = []
    x = search_vertex(end_vertex)
    until x.parent == nil
      path << x.value
      x = search_vertex(x.parent)
    end
    path << x.value
  end

  def knight_tour(u, n = 0, path = [], limit = 64)
    temp_vertex = search_vertex(u)
    temp_vertex.color = 'gray'
    path << temp_vertex.value
    print temp_vertex.value
    if n < limit
      connection = temp_vertex.edges.get_list()
      i = 0
      done = false
      while i < connection.size && !done
        current = search_vertex(connection[i])
        if current.color == 'white'
          done = knight_tour(connection[i], n + 1, path, limit)
        end
        i += 1
      end
      if done == false
        path.pop()
        temp_vertex.color = 'white'
      end
    else
      done = true
    end
  end

end

#create graph that represents classic 8x8 chess board. Every square is vertex, every vertex has 
#list of possible knight moves form current position on board 
def create_knight_tour_graph(board_size)
  new_graph = Graph.new()
  board_size.times do |x|
    board_size.times do |y|
      new_graph.add_vertex([x,y])
    end
  end
  knight_legal_moves(new_graph)
  new_graph
end 

def knight_legal_moves(graph)
  legal_positions = [[-1,-2],[-1,2],[-2,-1],[-2,1],[1,-2],[1,2],[2,-1],[2,1]]
  graph.vertices.each do |vertex|
    x = vertex.value[0]
    y = vertex.value[1]
    legal_positions.each do |move|
      a = move[0]
      b = move[1]
      temp_positon = [x + a, y + b]
      graph.add_edge(vertex.value, temp_positon) if graph.contains_vertex?(temp_positon)
    end
  end
end

graph = create_knight_tour_graph(5)
#p graph.knight_tour([0,0])
#p graph.depth_first_warnsdorffs([0,0])
#graph.print_graph()
graph.dfs_x()
