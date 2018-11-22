require_relative "DS6_stack_with_linked_list.rb"

class Queue
  attr_accessor :first_stack, :second_stack
  def initialize()
    @first_stack = Stack.new()
    @second_stack = Stack.new()
  end

  def is_empty?()
    (@first_stack.is_empty?()) ? true : false
  end

  def enqueue(value)
    if self.is_empty?()
      @first_stack.push(value)
      return
    end
    until @first_stack.is_empty?()
      temp_node = @first_stack.pop()
      @second_stack.push(temp_node)
    end
    @second_stack.push(value)
    until @second_stack.is_empty?()
      temp_node = @second_stack.pop()
      @first_stack.push(temp_node)
    end
  end

  def dequeue()
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

  def queue_size()
    @first_stack.stack_size()
  end

  def display()
    temp_node = @first_stack.top 
    print "Out "
    until temp_node == nil
      print "<- [#{temp_node.value}] "
      temp_node = temp_node.link 
    end
    puts "<- Out"
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
