require_relative "DS5_stack_with_array.rb"
# reverse string using explicit stack
def reverse_string(string)
  #time complexity and space compexity O(n), there are 2 loops but they are not nested
  #each loop is O(n)
  return nil if string.class != String #check if input os correct
  local_stack = Stack.new() #create new Stack instance
  string.each_char do |char| #insert all character from string into stack
    local_stack.push(char)
  end
  string.length.times do |i| #reassign characters with stack values (FILO)
    string[i] = local_stack.pop()
  end
  string
end
#p reverse_string('Neo')

#reverse array using explicit stack
def reverse_array(array)
  return nil if array.class != Array
  local_stack = Stack.new()
  array.each do |element|
    local_stack.push(element)
  end
  array.size.times do |i|
    array[i] = local_stack.pop()
  end
  array
end
#p reverse_array(['A','B','C'])

#check if parenthesis are valid (opend/closed) in string format
def parenthesis_checker(expression)
  return nil if expression.class != String
  opening = ["(", "{", "["] 
  closing = [")", "}", "]"]
  local_stack = Stack.new()
  #traversal the expresion searching for opening and closing elements
  expression.each_char do |char|
    if opening.include?(char) #if char is opening push it to stack
      local_stack.push(char)
    elsif closing.include?(char) #if char is closing, check for 2 conditions
      #1. if stack is empty, and iteration is checking closing symbol, opening is missing
      #2. if current closing symbol is not equal to opening in stack(top), missmatch
      if local_stack.is_empty?() || !is_parenthesis_pair?(local_stack.top(), char)
        return puts "expression has invalid parenthesis"
      else #else pop top opening symbol from stack
        local_stack.pop()
      end
    end
  end
  puts (local_stack.is_empty?()) ? "expression has valid parenthesis" :
      "expression has invalid parenthesis"
end

def is_parenthesis_pair?(opening, closing) #helper method for parenthesis_checker
  return true if opening == "(" && closing == ")"
  return true if opening == "{" && closing == "}"
  return true if opening == "[" && closing == "]"
  false
end
#parenthesis_checker("[(){}()]")
#parenthesis_checker(")(")
#parenthesis_checker("[(])")

#postfix evaluation
def do_math(num1, num2, operator)
  num1 = num1.to_i
  num2 = num2.to_i
  result = nil
  case operator
    when "+" then result = num1 + num2
    when "-" then result = num1 - num2
    when "*" then result = num1 * num2
    when "/" then result = num1 / num2
    when "**" then result = num1 ** num2
  end
  result.to_s
end

def postfix_evaluation(expression)
  return nil if expression.class != String
  digits = ["0", "1", "2", "3", "4", "5","6", "7", "8", "9"]
  operators = ["+", "-", "*", "/", "**"]
  expression_array = expression.split(" ")
  local_stack = Stack.new()
  expression_array.each do |element|
    if digits.include?(element)
      local_stack.push(element)
    elsif operators.include?(element)
      num2 = local_stack.pop()
      num1 = local_stack.pop()
      result = do_math(num1, num2, element)
      local_stack.push(result)
    else
      puts "undefined character"
      return
    end
  end
  local_stack.top()
end
#p postfix_evaluation("2 3 * 5 4 * + 9 -")
#prefix evaluation
def prefix_evaluation(expression)
  return nil if expression.class != String
  digits = ["0", "1", "2", "3", "4", "5","6", "7", "8", "9"]
  operators = ["+", "-", "*", "/", "**"]
  expression_array = expression.split(" ").reverse
  local_stack = Stack.new()
  expression_array.each do |element|
    if digits.include?(element)
      local_stack.push(element)
    elsif operators.include?(element)
      num1 = local_stack.pop()
      num2 = local_stack.pop()
      result = do_math(num1, num2, element)
      local_stack.push(result)
    else
      puts "undefined character"
    end
  end
  local_stack.top()
end
#p prefix_evaluation("- + * 2 3 * 5 4 9")
#infix to postfix
def operator_precedance(operator)
  result = nil
  case operator
    when "+" then result = 1
    when "-" then result = 1
    when "*" then result = 2
    when "/" then result = 2
    when "**" then result = 3
  end
  result
end

def compare_precedance?(operator1, operator2)
  precedance1 = operator_precedance(operator1)
  precedance2 = operator_precedance(operator2)
  (precedance1 >= precedance2) ? true : false
end
#p compare_precedance?('-','*')

def infix_to_postfix(expression)
  return nil if expression.class != String
  opening = ["(", "{", "["] 
  closing = [")", "}", "]"]
  digits = ["0", "1", "2", "3", "4", "5","6", "7", "8", "9"]
  operators = ["+", "-", "*", "/", "**"]

  local_stack = Stack.new()
  result = String.new()
    
  expression.each_char do |char|
    if digits.include?(char)
      result += "#{char} "
    elsif operators.include?(char)
      while !local_stack.is_empty?() && compare_precedance?(local_stack.top, char) &&
          opening.include?(local_stack.top())
        result += "#{local_stack.top()} "
        local_stack.pop()
      end
      local_stack.push(char)
    elsif opening.include?(char)
      local_stack.push(char)
    elsif closing.include?(char)
      while !local_stack.is_empty?() && closing.include?(local_stack.top())
        result += "#{local_stack.top()} "
        local_stack.pop()
      end
      local_stack.pop()
    end
  end

  while !local_stack.is_empty?()
    result += "#{local_stack.top()} "
    local_stack.pop()
  end
  result.rstrip
end
p infix_to_postfix("2+3")
p infix_to_postfix("(2+3)*4-(5*6)")
#infix to prefix



