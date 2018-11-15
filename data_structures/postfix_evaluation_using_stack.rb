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
  (precedance1 >= precedance2) ? true : false
end



def infix_to_postfix(expression)
  return nil if expression.class != String
  #correct input is string where all numbers, operators and brackets are space separated
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
      while !local_stack.is_empty?() && local_stack.top() != "(" &&
           is_precedance_greater?(local_stack.top(), item)    
        #append result for top operator( one with higher precedance), and pop it
        result += "#{local_stack.top()} "
        local_stack.pop()
      end
      #if current operator has higher precedance the operator on top of the 
      #stack push it, or stack is empty
      local_stack.push(item) 
    elsif item == "(" #if character is opening bracket, push it to stack
      local_stack.push(item)
    elsif item == ")" #if iteration comes to closing bracket
      #append top then pop, until stack reach first opening bracket
      while !local_stack.is_empty?() && local_stack.top() != "("
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
  result.rstrip()
end
p infix_to_postfix("( ( 15 / ( 7 - ( 1 + 1 ) ) ) * 3 ) - ( 2 + ( 1 + 1 ) )")
 
def infix_to_prefix()
end

def postfix_evaluation()
end

def prefix_evaluation()
end



