class Graph
  class Node
    attr_accessor :value, :weight, :link
    def initialize(value, weight = - Float::INFINITY)
      @value = value
      @weight = weight
      @link = nil
    end
  end

  class LinkedList
    attr_accessor :head
    def initialize()
      @head = nil
    end
  end
  
  attr_accessor :node_list
  def initialize()
    @node_list = Array.new()
  end

  def add_node(value)
    if @node_list == nil
      @node_list << LinkedList.new()
  end

end

x = Node.new('A')
p x