def max_subarray(array)
  if array.size == 1 #base case, array size of 1
    return array[0] # when array size 1 return value of that element
  else
    mid = array.size / 2
    left = max_subarray(array.slice(0, mid))
    right = max_subarray(array.slice(mid, array.size - 1))
    left_sum = - Float::INFINITY # seting to lowest posible value of - infinity
    right_sum = - Float::INFINITY # seting to lowest posible value of - infinity
    sum = 0 # start sum
    i = mid # searching for right_sum, from middle to the end off array
    while i < array.size 
      sum += array[i] # along array update value of sum by adding value of current element along array to sum
      right_sum = [right_sum, sum].max # each iteration update right sum for grater value off static right_sum or changing sum
      i += 1
    end
    sum = 0 #reset sum
    j = mid - 1 # searching for right_sum, from middle to the start off array
    while j >= 0
      sum += array[j] # along array update value of sum by adding value of current element along array to sum
      left_sum = [left_sum, sum].max # each iteration update left_sum for grater value off static left_sum or changing sum
      j -= 1
    end
    [left, right, left_sum + right_sum].max # result is greater value from left, right and sum of left_sum and right_sum
  end
end


def kadane_algorithm(array) # looping over elements once, linear time
  max = array[0] #maximum subaray, start from first element so its maximum subaray atm
  sum = 0 
  (array.size - 1).times do |i| 
    if sum + array[i] > 0 # if sum and next element gives positive value
      sum += array[i] # update sum by adding elemet to it
      max = sum if sum > max # if sum is greater then max, sum is new maximum value
    else # if sum and next element gives negative value
      sum = 0 # reset sum to 0, start comparing from next array index
    end
  end
  max
end

def maximum_subarray_brute_force(array) #using brute_force solution
  #iterate over every posible pair
  total = array.min # minimum value in array is starting value for result
  chunk = []
  (array.size).times do |i|
    x = 0 #start position for array slices
    y = i + 1 #length of chank we slice
    until x == array.size
      if array[x, y].size == y #condion to eliminate leftovers, 
        #p array[x, y]          #if array is size of 4 and we take chunk of size 3, we have 1 left over        
        if total < array[x, y].sum #main condition for searching maximum subarray
          total = array[x, y].sum
          chunk = array[x, y]
        end
      end
      x += 1
    end
  end
  p chunk
  total
end

x = [3, -2, 5, -1]
y = [-2, -5, 6, -2, -3, 1, 5, -6]
z = [13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -4, 7]
p maximum_subarray_brute_force(z)
