class Stack
  class Node
    attr_accessor :value, :link
    def initialize(value)
      @value = value
      @link = nil
    end
  end

  attr_accessor :top
  def initialize()
    @top = nil
  end

  def push(value)
    new_node = Node.new(value)
    new_node.link = @top
    @top = new_node
  end

  def pop()
    value = @top.value
    @top = @top.link
    value
  end

  def top()
    @top.value
  end

  def is_empty?()
    (@top == nil) ? true : false
  end

  def display(stack = @top)
    puts "[#{stack.value}]"
    if stack.link != nil
      display(stack.link)
    end

  end

end

stack = Stack.new()
stack.push('A')
stack.push('B')
stack.push('C')
p stack.pop()
stack.display()