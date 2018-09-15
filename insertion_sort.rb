def insertion_sort(array)
  i = 1 # we start with assumption that first element is sorted, so we comparing with second
  until i == array.size # we check every element in array
    j = i # counter for inner loop, set to i we comparing elements from right to left in inner loop
    while j > 0 && array[j] < array[j - 1] # additional condition to skip if swap no needed
      if array[j] < array[j - 1] # if condition is true we swap position of elements
        array[j], array[j - 1] = array[j - 1], array[j]
      end
      j -= 1
    end
    i += 1
  end
  array
end

x = [5,2,4,6,1,3]
y = [1,2,3,4,5,6]
z = [6,5,4,3,2,1]
p insertion_sort(z)
