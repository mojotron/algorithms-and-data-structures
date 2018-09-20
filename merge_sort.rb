def merge_sort(array)
  if array.size < 2 # base case, if array is size of 1, its sorted
    return array
  else # divide & conquer, divide till you get arrays of size 1 (left, right)
    left = merge_sort(array[0, array.size / 2])
    right = merge_sort(array[array.size / 2, array.size - 1])
    # call helper method to reassemble array in sorted mener, where left and right
    # are already sorted*
    merge(left, right, array) 
  end
end

def merge(left, right, array) #left and right, must be sorted *
  l = 0 # 3 counet varibles for each attribute array
  r = 0 # keep position of elemet we are soring
  a = 0 # and change value on that position in array
 #first while loop, runs till we hit one size limit
  while l < left.size && r < right.size
    if left[l] <= right[r]
      array[a] = left[l]
      l += 1
      a += 1
    else
      array[a] = right[r]
      r += 1
      a += 1
    end
  end
  # after, me need to run leftover array and change attribute array
  # we change all remaining elements untik left or right size is reached
  while l < left.size # if left is leftover
    array[a] = left[l]
    l += 1
    a += 1
  end

  while r < right.size #if right is leftover
    array[a] = right[r]
    r += 1
    a += 1
  end

  array
end

x = [5,2,4,6,1]
y = [5,2,4,7,1,3,2,6]
p merge_sort(y)