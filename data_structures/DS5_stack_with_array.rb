class Stack #stack implementation using array
  #to create stack initialize Stack class with empty array, and pointer to the top
  #element in the stack, array index is starting with 0, so using in initialization pointer
  #one position less(which now points to non existing element)
  attr_accessor :stack, :top
  def initialize() 
    @stack = Array.new()
    @top = -1
  end
  #stack operations can be executed on either head or tail side, but time complexity 
  #MUST BE constant O(1)
  def push(value) #pushing element to the tail, that element is top
    @top += 1 #first increment pointer for 1, to point next empty spot in array
    @stack[@top] = value #then assign next empty spot with value
  end

  def pop() #deleting element from tail, but returning value of deleted element
    return nil if @top == -1
    value = @stack.delete_at(@top) #save value, and delete element from value
    @top -= 1 #move pointer of top to point correct top after deletion
    value #return value of deleted element for operations
  end

  def top() #top element in stack
    @stack[@top]
  end

  def is_empty?() #boolena check if stack is empty, if top is -1 stack is empty
    (@top == -1) ? true : false
  end

  def display(pointer = @top)
    #with current implementation operations are executed at the tail side of array
    #so to display list properly we need print elements in revers order
    #here is implementation using recursion and displaying stack real-world visualy
    return puts "stack is empty" if pointer == -1
    puts "[#{@stack[pointer]}]" 
    if pointer != 0
      self.display(pointer - 1)
    end
  end

  def stack_size()
    @top + 1 
  end
end

#stack application scenarios
#1.reverse a string, time complexity and space compexity O(n)
string = "Hello World!"
new_stack = Stack.new()
string.each_char do |char|
  new_stack.push(char)
end
(string.length).times do |i|
  string[i] = new_stack.pop()
end
#puts string

#2. reverse array
array = ['A', 'B', 'C']
new_stack = Stack.new()
array.each do |element|
  new_stack.push(element)
end
array.size.times do |i|
  array[i] = new_stack.pop()
end
#p array

#3.open/closed paratheses
a = "[(){}()]"
b  = ")("
c = "[(])"
def pair_checker(a,b)
  return true if a == '(' && b == ')'
  return true if a == '[' && b == ']'
  return true if a == '{' && b == '}'
  false
end

def parantheses_checker(math_expresion)
  opening = ["(", "[", "{"]
  closing = [")", "]", "}"]
  new_stack = Stack.new()
  math_expresion.each_char do |char|
    if opening.include?(char)
      new_stack.push(char)
    elsif closing.include?(char)
      if new_stack.is_empty? || !pair_checker(new_stack.top, char)
        return false 
      else
        new_stack.pop()
      end
    end
  end
  (new_stack.is_empty?) ? true : false
end

p parantheses_checker(a)