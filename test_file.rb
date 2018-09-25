def max_sub(array)
  p array
  if array.size == 1
    return array[0]
  else
    mid = array.size / 2
    left = max_sub(array.slice(0, mid))
    right = max_sub(array.slice(mid, array.size - 1))
    left_sum = - Float::INFINITY
    right_sum = - Float::INFINITY
    sum = 0
    i = mid - 1
    while i >= 0
      sum += array[i]
      left_sum = [left_sum, sum].max
      i -= 1
    end
    sum = 0
    i = mid
    while i < array.size
      sum += array[i]
      right_sum = [right_sum, sum].max
      i += 1
    end
    answer = [left, right].max
    [answer, right_sum + left_sum].max
  end
end

x = [3, -2, 5, -1]
p max_sub(x)