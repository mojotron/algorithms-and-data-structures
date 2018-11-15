def selection_sort(array)
	(array.size).times do |x|
		i = x #index of sorted part of array
		min = array[x] #lowest value elemnt
		min_i = x #index of element with lowest value
		while i < array.size
			if min > array[i] #search for lowest value in unsorted part of array
				min = array[i]
				min_i = i #keep track of lowest element index
			end
			i += 1
		end
		array[x], array[min_i] = array[min_i], array[x] #make swap
		end
	array
end

x = [5,2,4,6,1,3]
y = [1,2,3,4,5,6]
z = [6,5,4,3,2,1]
p selection_sort(z)