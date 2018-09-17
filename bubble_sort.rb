def bubble_sort(array)
  (array.size).times do 
    i = 0 
    swaps = false # if swap is false array is sorted*
    while i < (array.size - 1)       
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        swaps = true 
      end
      i += 1   
    end
    break if swaps == false # *and we exit loop, no need for n loops
  end
  array
end

x = [5,2,4,6,1,3]
y = [1,2,3,4,5,6]
z = [6,5,4,3,2,1]
p bubble_sort(z)