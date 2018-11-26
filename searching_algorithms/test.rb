def binary_search(value, list)
  min = 0
  max = list.size - 1
  mid = list.size / 2
  return nil if list.size == 0
  return list[mid] if list[mid] == value
  if value < list[mid]
    binary_search(value, list[min, mid])
  else
    binary_search(value, list[(mid + 1), max])
  end

end

x = [1,2,3,4,5,6,7,8]
p binary_search(8 ,x)