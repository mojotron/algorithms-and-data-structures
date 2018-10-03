# General formula: F(n) = F(n-1) + F(n-2)
# returning fibonacci number in sequence on position attribute 
def fibonacci_iterativ(position)
  return 0 if position == 0
  x = 0
  y = 1
  i = 1 #counter variable for right position in fibbonaci sequence
  while i < position
    #swaping reassigning poitions of x and y, x = y and y = x(reasigned) + y
    #x, y = y, x + y # <= swaping way
    temp = x #<= traditional way with temp variable for swaping values
    x = y
    y = temp + x
    i += 1
  end
  y
end

def fibonacci_recursive(position)
  return position if position < 2
  #recusion cuts down position until base case, then in stack add results (0s and 1s) together
  fibonacci_recursive(position - 1) + fibonacci_recursive(position - 2)
end

def fibbonaci_dynamic(position)
  list = [0,1]
  #using information from frist 2 positions in sequence, we can calclate rest with general formula
  for i in (2..position) 
    list[i] = list[i - 1] + list[i - 2]
  end
  list.last
end

def fibonacci_matrix(position)
  return position if position < 2
  result = default = [[1,1], #matrix represents values in fibonacci sequence from bot-right
                      [1,0]] #to top left, if we mutiply it with self it will return next values in sequence
  #mutiply result with defalut n - 2 times
  (position - 2).times do
    result = matrix_multiply(result, default)
  end
  result[0][0] #top right value is last value in sequence
end

def fibonacci_matrix_recursive(position)
  return position if position < 2
  result = default = [[1,1],
                      [1,0]] 
  #calling recursiv matrix_power until base case when position is 1
  result = matrix_power(result, position - 1)
  result[0][0]
end

def matrix_multiply(a,b) #helper method
  c = Array.new(a.size){Array.new(b[0].size){0}}
  c[0][0] = (a[0][0] * b[0][0]) + (a[0][1] * b[1][0])
  c[0][1] = (a[0][0] * b[0][1]) + (a[0][1] * b[1][1])
  c[1][0] = (a[1][0] * b[0][0]) + (a[1][1] * b[1][0])
  c[1][1] = (a[1][0] * b[0][1]) + (a[1][1] * b[1][1])
  c 
end

def matrix_power(matrix, n) #helper method
  #Basically all the time is in matrix_power, which is recursive: it tries to compute
  #the nth power of A by squaring the (n/2)th power.  
  default = [[1,1],
             [1,0]]
  if n == 1
    return matrix
  else
    x = matrix_power(matrix, n / 2)
    x = matrix_multiply(x,x)
  end
  #if n is odd, rounding down n/2 and squaring that power of A results 
  #in the (n-1)st power, which we "fix up" by multiplying one more factor of A.
  if n % 2 != 0
    x = matrix_multiply(x, default)
  end
  x
end

p fibonacci_iterativ(20)
p fibonacci_recursive(20)
p fibbonaci_dynamic(20)
p fibonacci_matrix(20)
p fibonacci_matrix_recursive(20)

=begin
def fibbonaci_binets(n)# binet = (((1 + sqrt(5)) ** n) - ((1 - sqrt(5)) ** n)) / ((2 ** n) * sqrt(5))
  #not algorithm implementation but matematical
  #((((1 + Math.sqrt(5)) ** n) - 
  #    ((1 - Math.sqrt(5)) ** n)) / 
  #       ((2 ** n) * Math.sqrt(5))).to_i
  if n == 1
    return 1
  else
    ((fibbonaci_binets(n / 2)) ** 2) * Math.sqrt(5)
  end
end
  
=end