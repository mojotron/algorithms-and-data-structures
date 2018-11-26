def jump_search(target, array) #for sorted array
  jump = Math.sqrt(array.size).to_i
  i = 0
  while i < array.size
    return i if target == array[i]
    if target < array[i]
      #
      while true
        return i if target == array[i]
        return nil if target > array[i]
        i -= 1
      end
      #
    end
    i += jump
  end
  nil
end

x = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610 ]
p x.size
p jump_search(56, x)
p x[10]