require_relative "DS6_stack_with_linked_list.rb"
require_relative "DS1_linked_list.rb"
# reverse string using explicit stack
def reverse_string(string)
  #time complexity and space compexity O(n), there are 2 loops but they are not nested
  #each loop is O(n)
  return nil if string.class != String
  local_stack = Stack.new()
  string.each_char { |char| local_stack.push(char) }
  string.length.times { |i| string[i] = local_stack.pop() }
  string
end
#p reverse_string('Neo')

#check if parenthesis are valid (opend/closed) in string format
def parenthesis_checker(expression)
  return nil if expression.class != String
  opening = ["(", "{", "["] 
  closing = [")", "}", "]"]
  local_stack = Stack.new()
  expression.each_char do |char|
    if opening.include?(char)
      local_stack.push(char)
    elsif closing.include?(char)
      if local_stack.is_empty?() || !is_parenthesis_pair?(local_stack.peek_value(), char)
        return false
      else
        local_stack.pop()
      end
    end
  end
  (local_stack.is_empty?()) ? true : false
end

def is_parenthesis_pair?(opening, closing) #helper method for parenthesis_checker
  return true if opening == "(" && closing == ")"
  return true if opening == "{" && closing == "}"
  return true if opening == "[" && closing == "]"
  false
end
#p parenthesis_checker("[(){}()]")
#p parenthesis_checker(")(")
#p parenthesis_checker("[(])")

#reverse Linked List using explicit stack(our Stack class,
# not computer memeory stack-implicit)
list = LinkedList.new() #create new simple LL with 3 elements
list.push('A')
list.push('B')
list.push('C')

def reverse_linked_list(list)
  return nil if list.class != LinkedList
  local_stack = Stack.new()
  #put all nodes from list into stack
  list_temp_node = list.head
  until list_temp_node == nil
    local_stack.push(list_temp_node.value)
    list_temp_node = list_temp_node.link
  end
  #reverse link and empty out stack
  local_stack_temp_top = local_stack.peek()
  list.head = local_stack_temp_top
  local_stack.pop()
  until local_stack.is_empty?()
    local_stack_temp_top.link = local_stack.peek()
    local_stack.pop()
    local_stack_temp_top = local_stack_temp_top.link
  end
  local_stack_temp_top.link = nil
  list.head
end
#list.head = reverse_linked_list(list)
#list.to_s()

