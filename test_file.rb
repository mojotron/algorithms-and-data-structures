def assemble_matrix(mat_list)
  mat_list.flatten!
  rows = columns = mat_list.length**(0.5)
  p rows
  final_matrix = (0..rows-1).map { |x| [] }
  p final_matrix
  (0..rows-1).each do |row|
    (0..columns-1).each do |column|
      offset = ( ( row / 2 ) * 8 ) +
               ( ( row % 2 ) * 2 ) +
               ( ( column / 2 ) * 2 ) +
               column
      p offset
      final_matrix[row] << mat_list[offset]
      p final_matrix
    end
  end
  final_matrix
end

c = [[[6, 6], [8, 9]],[[6, 6], [8, 9]],[[10, 9], [12, 12]],[[10, 9], [12, 12]]]

#a = assemble_matrix(c)
#p a

def matrix_assemble(matrices_array)
  #for this method i had big problems how to asembel it, didnt know how figure out math
  #big help from https://github.com/gcallah/algorithms/blob/master/Ruby/DivideAndConquer/matrix_multiplication.rb
  new_matrix = Array.new(matrices_array.size){Array.new(matrices_array.size){nil}}
  rows = columns = matrices_array.size
  matrices_array.flatten!
  (rows).times do |i|
    (columns).times do |j|
      target = ((i / 2) * 8) + ((i % 2) * 2) + ((j / 2) * 2) + j
      new_matrix[i][j] = matrices_array[target]
    end
  end
  new_matrix
end

p matrix_assemble(c)
0,1,4,5,2,3,6,7,8,9,12,13,10,11,14,15
