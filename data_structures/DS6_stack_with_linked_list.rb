class Stack #stack implemtation using Linked lists
  #for creating stack using LL we need helper class representing element in LL
  class Node 
    #node class has two variabile, one for data and other to link current node with next node
    attr_accessor :value, :link
    def initialize(value)
      @value = value
      @link = nil
    end
  end
  #when creating new stack, stack is empty(top is nil, without link)
  attr_accessor :top
  def initialize()
    @top = nil
  end
  #stack operations in linked list are executed on head side becasuse stack time complexity 
  #MUST BE constant O(1), if execution is done at tail side we first must traversal list,
  #there fore time complexity is linear O(n)
  def push(value) 
    #push in LL terminology means adding element to end, but here we are adding to beginning
    #of the list
    new_node = Node.new(value) #first create a new node
    new_node.link = @top #then save current list to new node link
    @top = new_node #reassign current top to new
  end

  def pop() 
    #pop in LL terminology means deleting element from the end, but here we are deleting
    #from the beginning of the list
    return nil if @top == nil
    value = @top.value
    @top = @top.link #reassign next element in the list as new head(top) deleting firs element in procces
    value
  end

  def peek() 
    #top element in stack, using method name peek here to avoid name errors with global 
    #variable of Stack class @top
    return nil if @top == nil
    @top #top element is first element in the list
  end

  def peek_value()
    return nil if @top == nil
    @top.value
  end

  def is_empty?() #boolena check if stack is empty, if top is -1 stack is empty
    (@top == nil) ? true : false
  end

  def display(stack = @top)
    #with current implementation operations are executed at the head side of LL
    #so to display list properly we need print elements in current order
    #here is implementation using recursion and displaying stack real-world visualy
    puts "[#{stack.value}]"
    if stack.link != nil
      self.display(stack.link)
    end
  end

  def stack_size()
    counter = 0
    return counter if @top == nil
    temp_node = @top
    until temp_node == nil
      temp_node = temp_node.link
      counter += 1
    end
    counter
  end
end


