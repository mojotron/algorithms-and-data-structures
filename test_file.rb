def fib(n)
  return n if n < 2
  r = [[1,1],[1,0]]
  r = power(r, n - 1)
  r[0][0]
end
def matrix_multiply(a,b) #helper method
  c = Array.new(a.size){Array.new(b[0].size){0}}
  c[0][0] = (a[0][0] * b[0][0]) + (a[0][1] * b[1][0])
  c[0][1] = (a[0][0] * b[0][1]) + (a[0][1] * b[1][1])
  c[1][0] = (a[1][0] * b[0][0]) + (a[1][1] * b[1][0])
  c[1][1] = (a[1][0] * b[0][1]) + (a[1][1] * b[1][1])
  c 
end

def power(m, n)
  d = [[1,1],[1,0]]
  return m if n == 1
  r = power(m, n/2)
  r = matrix_multiply(r,r)
  if n % 2 != 0
    r = matrix_multiply(r, d)
  end
  r
end

puts fib(9)

