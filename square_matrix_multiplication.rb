def square_matrix_multipication(matrix_a, matrix_b) #iteration
  matrix_c = create_new_square_matrix(matrix_a, matrix_b)
  #instead of helper method more ruby way sintax
  #matrix_d = Array.new(matrix_a.length){Array.new(matrix_b[0].length) {nil}}
  # C = A*B => A = n*m, B = m*p => C = n * p
  for i in (0...matrix_a.size) # 1.loop passiong through matrix_a top to bottom
    for j in (0...matrix_b[0].size) # 2.loop passing through matrix_b[0] left to right
      element = 0
      for k in (0...matrix_a[0].size) # 3.loop passing through matrix_a[0] left to right
        element += matrix_a[i][k] * matrix_b[k][j] # 3.loops give us posibiliti to walk trouhg matrix_b top to bottom
      end
      matrix_c[i][j] = element
    end  
  end
  matrix_c
end

def square_matrix(a,b)
  #works only on n * n matrices, A and B must be same dimensions n * n
  c = create_new_square_matrix(a,b)
  if a.size == 2
    c[0][0] = (a[0][0] * b[0][0]) + (a[0][1] * b[1][0])
    c[0][1] = (a[0][0] * b[0][1]) + (a[0][1] * b[1][1])
    c[1][0] = (a[1][0] * b[0][0]) + (a[1][1] * b[1][0])
    c[1][1] = (a[1][0] * b[0][1]) + (a[1][1] * b[1][1])
  else
    c11 = add_matrices(square_matrix(cut_matrix(a)[:x11], cut_matrix(b)[:x11]),
        square_matrix(cut_matrix(a)[:x12], cut_matrix(b)[:x21]))
    
    c12 = add_matrices(square_matrix(cut_matrix(a)[:x11], cut_matrix(b)[:x12]),
        square_matrix(cut_matrix(a)[:x12], cut_matrix(b)[:x22]))
     
    c21 = add_matrices(square_matrix(cut_matrix(a)[:x21], cut_matrix(b)[:x11]), 
        square_matrix(cut_matrix(a)[:x22], cut_matrix(b)[:x21]))
    
    c22 = add_matrices(square_matrix(cut_matrix(a)[:x21], cut_matrix(b)[:x12]), 
        square_matrix(cut_matrix(a)[:x22], cut_matrix(b)[:x22]))

    c = matrix_assemble([c11, c12, c21, c22])
  end
  c
end

def create_new_square_matrix(matrix_a, matrix_b) #helper method
  # to prepare new_matrix for multiplication, condition is 
  # matrix_a number of column must be equale matrix_b number of rows
  return false if matrix_a[0].size != matrix_b.size # check if matrices are multiplayble
  new_matrix = Array.new # set up place holder for new matrix, which is array
  (matrix_a.size).times do |i| # for each row in matrix_a
    new_matrix << Array.new # append new row in new_matrix
    (matrix_b[0].size).times do # for each element(column) in matrix_b
      new_matrix[i] << nil # apped element in new_matrix rows, which are columns in square matrix
    end
  end
  new_matrix
end

def cut_matrix(x)#helper method
  #slice bigger matrix on 4 smaller ones(4x4, in four 2x2)
  mid = x.size / 2
  a11 = x.slice(0, mid).map {|i| i.slice(0, mid)}
  a12 = x.slice(0, mid).map {|i| i.slice(mid, x[0].size - 1)}
  a21 = x.slice(mid, x.size - 1).map {|i| i.slice(0, mid)}
  a22 = x.slice(mid, x.size - 1).map {|i| i.slice(mid, x[0].size - 1)}
  {
    :x11 => a11, #top left part
    :x12 => a12, #top right part
    :x21 => a21, #bottom left part
    :x22 => a22  #bottom right part
  }
end

def add_matrices(a,b)#helper method
  #2 recursions calls which both return new matrix, cant do scalar addition
  #so ther must be matrices addition, by adding the corresponding entries together
  c = Array.new(a.size){Array.new(a[0].size){0}}
  for i in (0...a.size)
    for j in (0...a.size)
      c[i][j] = a[i][j] + b[i][j]
    end
  end
  c
end

def matrix_assemble(matrices_array)#helper method
  #for this method i had big problems how to asembel it, didnt know how figure out math
  #big help from https://github.com/gcallah/algorithms/blob/master/Ruby/DivideAndConquer/matrix_multiplication.rb
  new_matrix = Array.new(matrices_array.size){Array.new(matrices_array.size){nil}}
  #first create new n*n matrix using size of input, and save size in variables rows and columns
  rows = columns = matrices_array.size #they are needed for looping through new_matrix
  matrices_array.flatten!
  (rows).times do |i|
    (columns).times do |j|
      #this formula is key how to asseble new matrix
      target = ((i / 2) * 8) + ((i % 2) * 2) + ((j / 2) * 2) + j
      #target gives indexes 0,1,4,5,2,3,6,7,8,9,12,13,10,11,14,15
      #assign current new_matrix element with element of flatten matrices_array with index == target
      new_matrix[i][j] = matrices_array[target]
    end
  end
  new_matrix
end


a = [[0, 3, 5],
     [5, 5, 2]]
b = [[3, 4],
     [3, -2],
     [4, -2]]
c = [[1,1,1,1],
     [2,1,2,1],
     [1,2,1,2],
     [2,2,2,2]]
d = [[0,4],
     [5,2]]
e = [[2,5],
     [3,0]]

x = square_matrix(c,c)
x.each {|i| puts i.inspect}  

