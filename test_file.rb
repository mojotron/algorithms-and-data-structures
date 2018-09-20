def insertion_sort(arr)
  i = 1
  until i == arr.size
    j = i
    while j > 0 && arr[j] < arr[j - 1]
      arr[j], arr[j - 1] = arr[j - 1], arr[j]
      j -= 1
    end
    i += 1
  end
  arr
end

z = [6,5,4,3,2,1]
p insertion_sort(z)