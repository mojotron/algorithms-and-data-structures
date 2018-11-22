require_relative "DS6_stack_with_linked_list.rb"
#ther are two ways to make Queue using stack, making either enqueue method or dequeue method
#costly.
class Queue_with_costly_dequeue
  #in this approch new element is queue is just added to enqueue stack, 
  #but when dequeue method is called there is need of second stack (dequeue_stack).
  attr_accessor :enqueue_stack, :dequeue_stack
  def initialize() #initialize object instace with 2 instance of stack objects
    @first_stack = Stack.new() # add element to queue
    @second_stack = Stack.new() # remove element from queue
  end

  def is_empty?() #use stack is_empty? method, if frist stack is empty and queue is empty
    (@first_stack.is_empty?()) ? true : false
  end
  
  def enqueue(value) #adding new element is simple, youst push it to first stack
    @first_stack.push(value)
  end

  def dequeue() 
    #removing element from queue requirest additional stack, frist move all lements from first
    #stack to second, to get first element in first stack(first in queue), move all elements
    #to second stack, then first element in queue is on top of the second stack
    return puts "Queue is empty" if self.is_empty?()
    until @first_stack.is_empty?()
      temp_node = @first_stack.pop()
      @second_stack.push(temp_node)
    end
    #pop top element in second stack and save value
    value = @second_stack.pop() 
    #then return element from second stack to first element so first element in queue is last
    until @second_stack.is_empty?()
      temp_node = @second_stack.pop()
      @first_stack.push(temp_node)
    end
    value #return saved value using pop
  end

  def peek() #to get top peek element, traversal to last element in first stack
    if self.is_empty?()
      puts "Queue is empty" 
      return nil
    end
    temp_node = @first_stack.top
    until temp_node.link == nil
      temp_node = temp_node.link
    end
    temp_node.value
  end

  def queue_size() #size is size of the first stack, use stacks stack_size method
    @first_stack.stack_size()
  end

  def display() #display is similar to dequeue, to revers stack use local stack, and print it
    print "Out "
    local_stack = Stack.new()
    temp_node = @first_stack.top
    until temp_node == nil
      local_stack.push(temp_node.value)
      temp_node = temp_node.link
    end
    until local_stack.is_empty?()
      temp_node = local_stack.pop()
      print "<- [#{temp_node}]"
    end
    puts "<- In"
  end
end

class Queue_with_costly_enqueue < Queue_with_costly_dequeue
  #now first stack is container for queue data, second stack is used to moveing first element
  #in queue to the top of the first stack
  def enqueue(value)
    #if stack is empty simply push new element to the first stack
    if self.is_empty?() 
      @first_stack.push(value)
      return
    end
    #for next elements in queue, first move all existing elements in first stack to second
    until @first_stack.is_empty?()
      temp_node = @first_stack.pop()
      @second_stack.push(temp_node)
    end
    #then add new element to stack(this is last element in queue)
    @second_stack.push(value)
    #lastly, move all elements from second stack to first so first element in queue comes to top
    #of the first stack
    until @second_stack.is_empty?
      temp_node = @second_stack.pop()
      @first_stack.push(temp_node)
    end
  end

  def dequeue() #first element in queue is on top of first stack, so just pop it out
    if self.is_empty?()
      puts "Queue is empty"
      return nil
    end
    @first_stack.pop()
  end

  def peek()
    if self.is_empty?()
      puts "Queue is empty"
      return nil
    end
    @first_stack.peek_value()
  end

  def display() #just print elements in first stack order
    print "Out "
    temp_node = @first_stack.top
    until temp_node == nil
      print "<- [#{temp_node.value}]"
      temp_node = temp_node.link
    end
    puts "<- In"
  end
end
  
x = Queue_with_costly_dequeue.new()
x.dequeue()
x.enqueue('A')
x.enqueue('B')
x.enqueue('C')
p x.peek()
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