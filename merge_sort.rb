def merge_sort(array)
  if array.size < 2 # base case, if array is size of 1, its sorted
    return array
  else # divide & conquer, divide till you get arrays of size 1 (left, right)
    left = merge_sort(array[0, array.size / 2])
    right = merge_sort(array[array.size / 2, array.size - 1])
    merge(left, right, array) # call helper method to reassemble array in sorted mener
  end
end

def merge(left, right, array)
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
  # after, me need to run leftover array and change attribut array
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

p merge_sort(x)