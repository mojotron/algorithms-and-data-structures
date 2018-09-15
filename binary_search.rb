# Binary Search with while loop
def binary_search(target, array) #need to be sorted array
	while array.size > 0 
	# 3 variables for start, end and middle of array
		min = 0
		max = array.size - 1
		mid = array.size / 2
	# if logic for slicing array for next iteration
		if target == array[mid]
			return target
		elsif target < array[mid]
			array = array[0, mid]
		elsif target > array[mid]
			array = array[(mid + 1), max]	
		end
	end
	nil #if array size is less then 1 target not in array return nil
end

#Binary Search with recursion
def binary_search_recursion(target, array)
	min = 0
	max = array.size - 1
	mid = array.size / 2

	return array[mid] if array[mid] == target # base case for exiting recursion	
	return nil if array.size == 0 # if array size is less then 1 target not in array return nil
	# recursion call
	if target < array[mid]
		binary_search_recursion(target,array[0, mid])
	else
		binary_search_recursion(target, array[(mid + 1), max])
	end
end

x = (1..16).to_a
p binary_search(3, x)
p binary_search_recursion(3, x)
p binary_search(30, x)
p binary_search_recursion(30, x)