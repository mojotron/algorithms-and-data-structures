def selection_sort(array)
	(array.size).times do |x|
		
		min = array[x]
		min_i = x
		i = x
		while i < array.size
			if min > array[i]
				min = array[i]
				min_i = i 
			end
			i += 1
		end
		array[x], array[min_i] = array[min_i], array[x]
		end
	
	array
end

x = [5,2,4,6,1,3]
y = [1,2,3,4,5,6]
z = [6,5,4,3,2,1]
p selection_sort(z)