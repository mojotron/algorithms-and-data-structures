def interpolation_seach(target, array) 
  #array elements must be equaly ditributed for proper result
  while array.size > 0 #run loop as long there is element is array
    min = 0 #index of the first elemenr
    max = array.size - 1 #index of the last element
    #interpolation search works on probing poition of the targeted element in the array.
    #for probing is used math formula. Average time complexiti is O(log(log(n))
    probe = min + ((target - array[min]) * (max - min) / (array[max] - array[min]))
    #loop break condition, if formula retuns value lover then value of the first element in 
    #array of greater then last element in array
    if probe < min || probe > max 
      return nil
    elsif array[probe] == target
      return probe #returning the index of element in the array if match is found
    elsif target < array[probe]
      array = array[min, probe]
    elsif target > array[probe]
      array = array[(probe + 1), max]
    end
  end
  nil
end

def interpolation_seach_recursive(target, array)
  min = 0
  max = array.size - 1
  probe = min + ((target - array[min]) * (max - min) / (array[max] - array[min]))
  return nil if probe < min || probe > max
  return probe if target == array[probe]
  if target < array[probe]
    interpolation_seach_recursive(target, array[min, probe])
  else
    interpolation_seach_recursive(target, array[(probe + 1), max])
  end
end

def interpolation_seach_string(target, array)
  #array elements must be equaly ditributed for proper result
  while array.size > 0
    min = 0
    max = array.size - 1
    min_value = (array[min]).sum
    max_value = (array[max]).sum
    target_value = (target).sum
    probe = min + ((target_value - min_value) * (max - min) / (max_value - min_value))

    if probe < min || probe > max
      return nil
    elsif array[probe] == target
      return probe
    elsif target < array[probe]
      array = array[min, probe]
    elsif target > array[probe]
      array = array[(probe + 1), max]
    end
  end
  nil
end

x = [5, 10, 15, 20]
y = ['aaa', 'aab', 'aba', 'baa']
p interpolation_seach_recursive(1,x)
p interpolation_seach_recursive(5,x)
p interpolation_seach_recursive(10,x)
p interpolation_seach_recursive(15,x)
p interpolation_seach_recursive(20,x)
p interpolation_seach_recursive(25,x)
p interpolation_seach_string('a',y)
p interpolation_seach_string('aaa',y)
p interpolation_seach_string('aab',y)
p interpolation_seach_string('aba',y)
p interpolation_seach_string('baa',y)
p interpolation_seach_string('b',y)

#diff between binary
#Binary search always chooses the middle of the remaining search space, discarding one half or 
#the other, depending on the comparison between the key found at the estimated position and the 
#key sought — it does not require numerical values for the keys, just a total order on them. 
#The remaining search space is reduced to the part before or after the estimated position. 
#The linear search uses equality only as it compares elements one-by-one from the start, 
#ignoring any sorting. 
#when to use