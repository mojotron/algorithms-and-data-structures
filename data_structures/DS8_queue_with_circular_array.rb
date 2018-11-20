class Queue 
  #implementation of space limited queue with circular array
  #current element in circular array of size n, is x
  #next element is (x + 1) % n, and previous element is (x + n - 1) % n
  attr_accessor :space_limit, :queue, :head, :tail
  def initialize(space_limit = 10)
    @space_limit = space_limit 
    @queue = Array.new()
    @head = -1
    @tail = -1
  end
  #rear side is used to append elements to the queue, front side is used to delete element from the 
  #queue, operations accept display MUST have constant time complexity O(1)
  def is_empty?()
    (@head == -1 && @tail == -1) ? true : false
  end

  def is_full?() #if tail next is equal to head list is full
    ((@tail + 1) % space_limit == @head) ? true : false
  end

  def enqueue(value) #add element to queue
    if self.is_full?() #if queue is full exit
      return puts "Queue is full!"
    elsif self.is_empty?()
      #if queue is empty first set up queue for first element, seting pointers to index 0 
      @head = 0
      @tail = 0
    else
      #if there are already some elements in queue then move tail pointer to next element
      @tail = (@tail + 1) % space_limit
    end
    @queue[@tail] = value #pointer is set, now write/overwrite element at pointed index
  end

  def dequeue()
    value = nil #container for value thet will be removed from the queue
    if self.is_empty?() #if array is empty nothing to remove
      puts "Queue is empty"
    elsif @head == @tail #if there is only 1 element in queue
      value = @queue[@head] #save value
      @head = -1 #set up variables to -1 marking queue is empty
      @tail = -1
    else
      value = @head
      @head = (@head + 1) % space_limit #more then 1 element, move head pointer to next element
    end
    value 
  end

  def peek()
    return puts "Queue is empty" if self.is_empty?()
    @queue[@head]
  end

  def queue_size() #size of circualr array depends where pointers are positioned
    return 0 if self.is_empty?()
    (@head > @tail) ? (space_limit - @head + @tail + 1) : (@tail - @head + 1);
  end

  def display() #display of circular array
    return puts "Queue is empty!" if self.is_empty?()
    container = Array.new() #create new container 
    2.times do #append 2 times all elements in queue to container
      @queue.each do |item|
        container << item
      end
    end
    #to print out elements in queue in right order, start from index of head and print out
    #number of elements equal to size of queue from head index
    print "out "
    container[@head,self.queue_size()].each do |item|
      print "<- #{item} "
    end
    puts "<- in"
  end
end

list = Queue.new(3)
list.display()
list.enqueue('A')
list.enqueue('B')
list.enqueue('C')
list.display()
list.dequeue()
list.display()
list.dequeue()
list.display()
list.enqueue('X')
list.enqueue('Y')
list.display()
