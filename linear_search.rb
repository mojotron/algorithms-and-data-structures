def linear_search(target, array)
  i = 0 # array elements counter
  until i == array.size
    return array[i] if array[i] == target
    i += 1
  end
  nil #worst case, target not in array, iteration goes through all elements
end

x = [5,2,4,6,1,3]
p linear_search(3, x)
p linear_search(7,x)