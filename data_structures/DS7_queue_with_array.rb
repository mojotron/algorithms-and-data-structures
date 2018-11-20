class Queue 
  #implemntation without capacity, queue is not space limited
  attr_accessor :queue, :head, :tail
  def initialize()
    #initialize queue object with new array and pointers to first element ans last
    @queue = Array.new() 
    @head = 0 #head never change, pointer to first element in the array
    @tail = -1 #use -1 for checking if queue is empty, tail index change with every insert/delete
  end
  #rear side is used to append elements to the queue, front side is used to delete element from the 
  #queue, operations accept display MUST have constant time complexity O(1)
  def is_empty?()
    (@tail == -1) ? true : false
  end

  def enqueue(value) #appending element at the end of the queue
    @tail += 1 #first increment pointer then append value
    @queue[@tail] = value 
  end

  def dequeue() #delete element from beginning of the queue
    return nil if self.is_empty?() #check if queue is empty
    value = @queue.delete_at(@head) #save value of the element and delete it
    @tail -= 1 
    value
  end

  def peek() #return value of the first element in the queue
    return puts "queue is empty" if self.is_empty?()
    @queue[@head]
  end

  def queue_size()
    @tail + 1
  end

  def display() #displaying queue real-world visualy
    print "Out "
    @queue.each do |item|
      print "<- [#{item}] "
    end
    puts "<- In"
  end

end

list = Queue.new()
list.enqueue('A')
list.enqueue('B')
list.enqueue('C')
list.dequeue()
p list.peek()
p list.queue_size()
list.display()