require_relative "DS16_graph_with_adjecency_list.rb"

class Graph 
  class Vertex
    attr_accessor :value, :edges ,:visited, :parent
    def initialize(value)
      @value = value
      @edges = LinkedList.new()
      #additional variables for packtracking path
      @visited = false
      @parent = nil
    end
  end 
  #this is shortest path problem with unweighted graph, BFS is best solution
  def bradth_first_search(start_vertex, stop_vertex)
    queue = Array.new()
    queue << search_vertex(start_vertex)
    until queue.empty?
      temp_vertex = queue.shift()
      break if temp_vertex.value == stop_vertex
      vertex_edges = temp_vertex.edges.head
      until vertex_edges == nil
        current = search_vertex(vertex_edges.value)
        if current.visited == false
          current.visited = true
          current.parent = temp_vertex.value
          queue << current
        end
        vertex_edges = vertex_edges.link
      end
      temp_vertex.visited = true
    end
    graph_traversal(start_vertex, stop_vertex)
  end

  def graph_traversal(start_vertex, stop_vertex)
    path = Array.new()
    current_vertex = search_vertex(stop_vertex)
    until current_vertex.parent == nil
      path << current_vertex.value
      current_vertex = search_vertex(current_vertex.parent)
    end
    path << current_vertex.value
    path.reverse
  end
end

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
  legal_positions = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
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

graph = create_knight_tour_graph(8)
p graph.bradth_first_search([3,3],[4,3])


