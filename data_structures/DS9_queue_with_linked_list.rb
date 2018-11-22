class Queue
  class Node
    attr_accessor :value, :link
    def initialize(value)
      @value = value
      @link = nil
    end
  end

  attr_accessor :head, :tail
  def initialize()
    @head = nil
    @tail = nil #***
  end
  #basic operations MUST have constatn time complexity O(1), in normal LL implementation 1 side
  #have constatnt time, but tail side have linear time, we traversal to tail. So to accomplish
  #requirement of queues constatnt time, list must have tail pointer(***) also, not just head pointer.
  def is_empty?()
    (@head == nil) ? true : false
  end

  def enqueue(value)
    new_node = Node.new(value)
    if self.is_empty?() #if queue is empty both head and tail points to same node
      @head = new_node
      @tail = new_node
      return
    end 
    #if queue is not empty, first assign tail.link to new node, with thet and heads link points
    #to next node. Then reasign tail as new node
    @tail.link = new_node
    @tail = new_node
  end

  def dequeue()
    if self.is_empty?()
      puts "Queue is empty" 
      return 
    end
    value = @head.value
    if @head == @tail
      #if list has 1 element, reset list
      @head = nil
      @tail = nil
      return value
    end
    #if list has more then 1 element shift first element
    new_head = @head.link
    @head = new_head
    value
  end

  def peek()
    if self.is_empty?()
      puts "Queue is empty"
      return nil 
    end
    @head.value
  end

  def queue_size()
    counter = 0
    return counter if self.is_empty?()
    temp_node = @head
    until temp_node == nil
      counter += 1
      temp_node = temp_node.link
    end
    counter
  end

  def display()
    temp_node = @head
    print "Out "
    until temp_node == nil
      print "<- [#{temp_node.value}] "
      temp_node = temp_node.link
    end
    puts "<- In"
  end
  
end

x = Queue.new()
x.enqueue('A')
x.enqueue('B')
x.enqueue('C')
x.display()
x.dequeue()
x.display()
x.dequeue()
x.display()
x.enqueue('X')
x.enqueue('Y')
x.display()
p x.queue_size()
p x.peek()
p x.head
p x.tail
