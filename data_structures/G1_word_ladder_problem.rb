require_relative "DS16_graph_with_adjecency_list.rb"
#using words with 3 letter for faster runtime
list_of_words = "english_dictionary/three_letter_words.txt"
#first create bucket of words thet differ 1 letter
buckets_list = Hash.new()
words_file = File.new(list_of_words, 'r')
words_file.each do |line|
  word = line.chomp
  i = 0 #pointer current letter in loop
  while i < word.length
    bucket = word[0...i] + '_' + word[i + 1..-1] #create key for bucket hash like d_g
    if buckets_list.include?(bucket) #check if bucket is already in bucket list
      buckets_list[bucket] << word #append current word it existing bucket
    else
      buckets_list[bucket] = [word] #create new bucket and append arrey with word init
    end
    i += 1
  end
end

class Graph #modify imported graph class for this problem
  class Vertex 
    attr_accessor :value, :edges, :color, :parent, :distance, :visited
    def initialize(value)
      @value = value #original vertex variable
      @edges = LinkedList.new() #original vertex variable
      #add for solution with colors & visited flag variable
      @color = 'white'
      @parent = nil
      @distance = 0
      @visited = false
    end
  end 
  #implement BFS method, this is shortest path problem with unweighted graph, BFS is best solution
  def bradth_first_search_colors(start_vertex, stop_vertex)
    queue = Array.new()
    queue << search_vertex(start_vertex)
    until queue.empty?
      temp_vertex = queue.shift()
      break if temp_vertex.value == stop_vertex #found stop condition
      vertex_edges = temp_vertex.edges.head
      until vertex_edges == nil
        current_vertex = search_vertex(vertex_edges.value)
        if current_vertex.color == 'white'
          current_vertex.color = 'gray' #indicates that shorter path is available if found again
          current_vertex.distance = temp_vertex.distance + 1
          current_vertex.parent = temp_vertex.value
          queue << current_vertex
        end
        vertex_edges = vertex_edges.link
      end
      temp_vertex.color = 'black' #completly explored tree
    end
    graph_traversal(start_vertex, stop_vertex)
  end

  def bradth_first_search_visited(start_vertex, stop_vertex)
    queue = Array.new()
    queue << search_vertex(start_vertex)
    until queue.empty?
      temp_vertex = queue.shift()
      break if temp_vertex.value == stop_vertex
      vertex_edges = temp_vertex.edges.head
      until vertex_edges == nil
        current_vertex = search_vertex(vertex_edges.value)
        if current_vertex.visited == false
          current_vertex.parent = temp_vertex.value
          current_vertex.visited = true
          queue << current_vertex
        end
        vertex_edges = vertex_edges.link
      end
      temp_vertex.visited = true
    end
    graph_traversal(start_vertex, stop_vertex)
  end

  def graph_traversal(start_vertex, stop_vertex)
    #connect path via parent link
    path = Array.new()
    current_vertex = search_vertex(stop_vertex)
    until current_vertex.parent == nil
      path.unshift(current_vertex.value)
      current_vertex = search_vertex(current_vertex.parent)
    end
    path.unshift(current_vertex.value)
  end
end

#create graph 
graph = Graph.new()
#create vertices
buckets_list.keys.each do |key|
  buckets_list[key].each do |word|
    graph.add_vertex(word)
  end
end
#create edges
buckets_list.keys.each do |key|
  buckets_list[key].each do |x|
    buckets_list[key].each do |y|
      graph.add_edge(x,y) if x != y
    end
  end
end

#p graph.bradth_first_search_colors('dog','cat')
p graph.bradth_first_search_visited('dog','cat')

