require_relative "test.rb"
list_of_words = "english_dictionary/three_letter_words.txt"
buckets = Hash.new()
#create buckest, each bucket holds all words that are diff by 1 char
word_file = File.open(list_of_words, 'r')
word_file.each do |line|
  word = line.chomp
  i = 0
  while i < word.length
    bucket = "#{word[0...i]}_#{word[i+1..-1]}"
    if buckets.include?(bucket)
      buckets[bucket] << word
    else
      buckets[bucket] = [word]
    end
    i += 1
  end
end
#modify graph class
class Graph
  class Vertex
    attr_accessor :value, :edges, :distance, :parent, :color, :visited
    def initialize(value)
      @value = value
      @edges = LinkedList.new()
      #extend vertex class with extra 3 instance variables
      @distance = 0 #
      @parent = nil #
      @color = "white" # white is undiscovered vertex, grey is initialy discovered, black is discovered
      @visited = false
    end
  end

  def breadth_first_search(start_vertex, target_vertex)
    queue = Array.new()
    queue.push(search_vertex(start_vertex))
    until queue.empty?
      temp_vertex = queue.shift()
      return if temp_vertex.value == target_vertex
      temp_edge = temp_vertex.edges.head
      until temp_edge == nil
        edge_vertex = search_vertex(temp_edge.value)
        if edge_vertex.color == 'white'
          edge_vertex.color = 'gray' #indicates that shorter path is available if found again
          edge_vertex.distance = temp_vertex.distance + 1
          edge_vertex.parent = temp_vertex.value
          queue.push(edge_vertex)
        end
        temp_edge = temp_edge.link
      end
      temp_vertex.color = 'black'
    end
  end

  def bfs(start_vertex, target_vertex) #Without colors, but with flag
    queue = Array.new()
    queue.push(search_vertex(start_vertex))
    until queue.empty?
      temp_vertex = queue.shift()
      temp_edge = temp_vertex.edges.head 
      until temp_edge == nil
        edge_vertex = search_vertex(temp_edge.value)
        if edge_vertex.visited == false
          edge_vertex.visited = true
          edge_vertex.parent = temp_vertex.value
          queue.push(edge_vertex)
        end
        temp_edge = temp_edge.link
      end
      temp_vertex.visited = true
    end
  end

  def path_traversal(vertex)
    container = Array.new()
    start = search_vertex(vertex)
    container << start.value
    until start.parent == nil
      container << start.parent
      start = search_vertex(start.parent)
    end
    
    container.reverse
  end
end
#create new graph
word_graph = Graph.new()
#add vertices to graph
buckets.keys.each do |key|
  buckets[key].each do |word|
    word_graph.add_vertex(word)
  end
end
#add edges between words with 1 diff letter
buckets.keys.each do |key|
  buckets[key].each do |a|
    buckets[key].each do |b|
      word_graph.add_edge(a, b) if a != b
    end
  end
end

word_graph.bfs('tic', 'zoo')

p word_graph.path_traversal('zoo')
