def maximum_subarray(array) #using divide & conquer solution
end

def maximum_subarray_brute_force(array) #using brute_force solution
  #iterate over every posible pair
  total = array.min # minimum value in array is starting value for result
  chunk = []
  (array.size).times do |i|
    x = 0 #start position for array slices
    y = i + 1 #length of chank we slice
    until x == array.size
      if array[x, y].size == y #condion to eliminate leftovers, algoritam already
        p array[x, y]          # passed in previous iteration with lesser i        
        if total < array[x, y].sum #main conditio for searchin maximum subarray
          total = array[x, y].sum
          chunk = array[x, y]
        end
      end
      x += 1
    end
  end
 total
end

x = [3,-2,5,-1]
p maximum_subarray_brute_force(x)
