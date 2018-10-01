def subtract_matrices(a,b)
  c = Array.new(a.size){Array.new(a[0].size){0}}
  for i in (0...a.size)
    for j in (0...b[0].size)
      c[i][j] = a[i][j] - b[i][j]
    end
  end
  c
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

x = [[1,1,1,1],
     [2,1,2,1],
     [1,2,1,2],
     [2,2,2,2]]

#subtract_matrices(x,x).each{|i| p i.inspect}
z4 = subtract_matrices(cut_matrix(x)[:x12], cut_matrix(x)[:x22])
p z4

