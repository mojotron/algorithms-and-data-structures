require_relative "DS5_stack_with_array.rb"
#postfix evaluation on string data structure
#helper methods
def is_digit?(char) 
  (char.match(/^\d+$/)) ? true : false
end

def is_operator?(char)
  (("+-*/**").include?(char)) ? true : false
end

def is_opening?(char)
  ("([{".include?(char)) ? true : false
end

def is_closing?(char)
  (")]}".include?(char)) ? true : false
end

def are_bracket_pair?(opening, closing)
  return true if opening == "(" && closing == ")"
  return true if opening == "[" && closing == "]"
  return true if opening == "{" && closing == "}"
  false
end

def bracket_check?(expression) #are brackets opend and closed regulary
  return nil if expression.class != String
  local_stack = Stack.new()
  expression.each_char do |char|
    if is_opening?(char)
      local_stack.push(char)
    elsif is_closing?(char)
      if !local_stack.is_empty?() && !are_bracket_pair?(local_stack.top(), char)
        return false
      else
        local_stack.pop()
      end
    end
  end
  (local_stack.is_empty?()) ? true : false
end

def do_math(operand1, operand2, operator)
  x = operand1.to_i if is_digit?(operand1)
  y = operand2.to_i if is_digit?(operand2)
  result = nil
  case operator
    when "+" then result = x + y
    when "-" then result = x - y
    when "*" then result = x * y
    when "/" then result = x / y
    when "**" then result = x ** y
  end
  result.to_s # return string resoult representation
end

def operator_precedance(operator)
  precedance_score = nil
  case operator
    when "+" then precedance_score = 1
    when "-" then precedance_score = 1
    when "*" then precedance_score = 2
    when "/" then precedance_score = 2
    when "**" then precedance_score = 3
  end
  precedance_score
end

def is_precedance_greater?(operator1, operator2)
  precedance1 = operator_precedance(operator1)
  precedance2 = operator_precedance(operator2)
  (precedance1 > precedance2) ? true : false
end

def correct_mutidigit_numbers(expression)
  expression = expression.split(" ")
  expression.each do |item|
    if is_digit?(item) && item.length > 1
      item = item.reverse()
    end
  end
  p expression
  expression.join(" ")
  
end

def infix_to_postfix(expression)
  #correct input is string where all numbers, operators and brackets are space separated
  return false if expression.class != String
  return false if !bracket_check?(expression)
  #split input into array where al space separated charaters are array items
  expression = expression.split(" ")
  local_stack = Stack.new()
  result = String.new()
  
  expression.each do |item|
    if is_digit?(item) #if item is number push it to stack
      result += "#{item} "
    elsif is_operator?(item) #if item is operator, first check 3 conditions
      #this is part where we compare operator pecedance in the stack and current operator
      #1. if stack is not empty AND
      #2. if top is not opening bracket
      #3. if current operator(in loop) has lower precedance then operator on top of the stack
      while !local_stack.is_empty?() && !is_opening?(local_stack.top()) &&
           is_precedance_greater?(local_stack.top(), item)    
        #append result for top operator( one with higher precedance), and pop it
        result += "#{local_stack.top()} "
        local_stack.pop()
      end
      #if current operator has higher precedance the operator on top of the 
      #stack push it, or stack is empty
      local_stack.push(item) 
    elsif is_opening?(item) #if character is opening bracket, push it to stack
      local_stack.push(item)
    elsif is_closing?(item) #if iteration comes to closing bracket
      #append top then pop, until stack reach first opening bracket same type as closing
      while !local_stack.is_empty?() && !is_opening?(local_stack.top()) &&
           !are_bracket_pair?(local_stack.top(), item)
        result += "#{local_stack.top()} "
        local_stack.pop()
      end
      #additional pop to remove opening bracket which was stop condition in while loop
      local_stack.pop() 
    end
  end
  #remove leftover operators for stack and append them to resoult container
  until local_stack.is_empty?()
    result += "#{local_stack.top()} "
    local_stack.pop()
  end
  result.rstrip() #return string without space leftover
end

def infix_to_prefix(expression)
  return false if expression.class != String
  return false if !bracket_check?(expression)
  expression = expression.split(" ").reverse()
  p expression
  local_stack = Stack.new()
  result = String.new()
  #we have reverse input, now logic declare that opening bracket is closing and vice versa
  #diff form infix_to_postfix is swap opening for colsing and closing for opening brackets
  #and reverse ecpresion before loop and after loops
  expression.each do |item|
    if is_digit?(item)
      #if digit has more then 1 character(digit is string), revers it, because method returning reverse
      #result in the end, and multidigit string will be incorrect ("123" will be "321") and with thet
      if item.length > 1
        result += " #{item.reverse}"
      else
        result += " #{item}"
      end
    elsif is_operator?(item)
      while !local_stack.is_empty?() && !is_closing?(local_stack.top()) &&
           is_precedance_greater?(local_stack.top(), item)
        result += " #{local_stack.top()}"
        local_stack.pop()
      end
      local_stack.push(item)
    elsif is_closing?(item) #string is reversed so here check for closing not opening *
      local_stack.push(item)
    elsif is_opening?(item) #*
      while !local_stack.is_empty?() && !is_closing?(local_stack.top()) &&
        !are_bracket_pair?(local_stack.top(), item)
        result += " #{local_stack.top()}"
        local_stack.pop()
      end
      local_stack.pop()
    end
  end
  #remove leftover operators for stack and append them to resoult container
  until local_stack.is_empty?()
    result += " #{local_stack.top()}"
    local_stack.pop()
  end
  result = correct_mutidigit_numbers(result)
  result.reverse().rstrip() #reverse result and remove extra space
end

def postfix_evaluation(expression)
  return false if expression.class != String
  expression = expression.split(" ")
  local_stack = Stack.new()

  expression.each do |item|
    if is_digit?(item)
      local_stack.push(item)
    elsif is_operator?(item)
      #operands are in revers order inside stack so first operand in espression is second in stack
      operand2 = local_stack.pop()
      operand1 = local_stack.pop()
      #evalute math expresion as it in input, first and second operand, item in iteration is operator
      result = do_math(operand1, operand2, item)
      local_stack.push(result) #push result on top of the stack
    end
  end
  local_stack.top() #final result is top of the local stack
end

def prefix_evaluation(expression)
  return false if expression.class != String
  #reverse expression, operands are at the end, to put them on beginning of array
  expression = expression.split(" ").reverse()
  local_stack = Stack.new()
  expression.each do |item|
    if is_digit?(item)
      local_stack.push(item)
    elsif is_operator?(item)
      #operands are put in stack in revers order, but we reversed before loop, thet means
      #they are now in order like non altered input
      operand1 = local_stack.pop()
      operand2 = local_stack.pop()
      result = do_math(operand1, operand2, item)
      local_stack.push(result) 
    end
  end
  local_stack.top()
end

x = infix_to_postfix("( ( 15 / ( 7 - ( 1 + 1 ) ) ) * 3 ) - ( 2 + ( 1 + 1 ) )")
y = infix_to_prefix("( ( 15 / ( 7 - ( 1 + 1 ) ) ) * 3 ) - ( 2 + ( 1 + 1 ) )")
p postfix_evaluation(x)
p prefix_evaluation(y)



