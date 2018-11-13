class CircularDoublyLinkedList
  class Node #helper clas for representing element in the CDLL
    #node class is same as node class in DLL, with links to next and previous element
    attr_accessor :value, :link_next, :link_prev
    def initialize(value) 
      @value = value
      @link_next = nil
      @link_prev = nil
    end
  end
  #CDLL upon creating is empty
  attr_accessor :head
  def initialize()
    @head = nil
  end
  #list size
  def list_size() 
    counter = 0
    return counter if @head == nil
    temp_node = @head
    loop do #traversal the list and for each element increment counter
      counter += 1
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    counter
  end
  #adding elements to DCLL
  def push(value) #append new element at the end of the list
    new_node = Node.new(value)
    #if list is empty, head becomes new node, links next and prev point to itself
    if @head == nil 
      @head = new_node
      @head.link_next = @head
      @head.link_prev = @head
      return
    end
    #if list is not empty, traverse to last element and reconnect links
    temp_node = @head #first make referece to list(last node)
    until temp_node.link_next == @head
      temp_node = temp_node.link_prev
    end
    temp_node.link_next = new_node #first append new node to last element
    new_node.link_prev = temp_node #then, connect new last element to temp_node
    new_node.link_next = @head #connect first and last element to make circle
    @head.link_prev = new_node
  end

  def unshift(value) #prepand value at the beginning of the list
    new_head = Node.new(value)
    #if list is empty, head becomes new head, links next and prev point to itself
    if @head == nil
      @head = new_head
      @head.link_next = @head
      @head.link_prev = @head
      return
    end
    #if list is not empty traversal to last element, needed for connecting new head with tail
    temp_node = @head
    until temp_node.link_next == @head
      temp_node = temp_node.link_next
    end
    new_head.link_next = @head #firs connect list already created to new_head
    @head.link_prev = new_head #then reconect heads prev link from tail to new head
    temp_node.link_next = new_head #connect new head with tail (abd vice versa)
    new_head.link_prev = temp_node
    @head = new_head #last step, make new head the head
  end

  def insert_at(value, index) #insert element at nth position
    list_size = self.list_size() #use list size for checking index range
    #position of elements cant be negative, we are allowing appending elements if user inputs
    #index greater then size of list
    return puts "out of range" if index < 0 
    #using already created methods for inserting at beginning or end of the list
    return self.unshift(value) if index == 0 || list_size == 0 #or @head == nil
    return self.push(value) if index >= list_size
    #in case inserting between head and tail
    counter = 1 #start counting from 1 (to insert node before element on nth position
    #(to insert node after element on nth position change counter to 0 initiali))
    temp_node = @head 
    until counter == index
      counter += 1
      temp_node = temp_node.link_next
    end
    new_node = Node.new(value) #after traversing to wanted position create ne node
    new_node.link_next = temp_node.link_next
    temp_node.link_next.link_prev = new_node
    new_node.link_prev = temp_node
    temp_node.link_next = new_node
  end
  #deleting elements from DCLL
  def pop() #delete last element in the list
    return nil if @head == nil #if list is empty nothing to delete
    return @head = nil if @head.link_next == @head #if list has 1 element head is nil(list is empty)
    #if list has mote then 1 element traversal until loop reach element before last element
    temp_node = @head
    until temp_node.link_next.link_next == @head
      temp_node = temp_node.link_next
    end
    #when pointer is at position just connect it to head and vice versa
    temp_node.link_next = @head 
    @head.link_prev = temp_node
  end

  def shift() #delete first element in the list
    return nil if @head == nil
    return @head = nil if @head.link_next == @head
    temp_node = @head #traversal to last element to save referece to it
    until temp_node.link_next == @head
      temp_node = temp_node.link_next
    end
    @head = @head.link_next #second element is now first element
    @head.link_prev = temp_node #connect, new head with tail to complete circle
    temp_node.link_next = @head
  end

  def delete_at(index) #delete element at nth position
    list_size = self.list_size()
    #value at list cant be at negative index, and here we dont allow deleting last element
    #if user input greater or equal index value then size of list, user must input correct index
    return puts "out of range" if index < 0 || index >= list_size
    #call shift method in case user whant to delete first element
    return self.shift() if index == 0 
    #call pop method in case user whant to delete last element
    return self.pop() if (list_size - 1) == index
    #case usr what to delete node in the middle of the list
    counter = 1
    temp_node = @head
    #move pointer before element we want to delete
    until counter == index
      temp_node = temp_node.link_next
    end
    #before bypassing next element store second element from current pointer
    store_node = temp_node.link_next.link_next
    temp_node.link_next = store_node #then just connect store and temp elements, bypassing
    store_node.link_prev = temp_node #element between them
  end
  #searching the elements in the list
  def search(value) #returns node with corenspondig data, nil if not found
    return nil if @head == nil
    temp_node = @head
    loop do
      return temp_node.value if temp_node.value == value
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    nil
  end

  def contains?(value) #return true / false if data(value) is in thr list
    return false if @head == nil
    temp_node = @head
    loop do 
      return true if temp_node.value == value
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    false
  end

  def value_at(index) #return corenspondig data at given index of the list
    list_size = self.list_size()
    return puts "out of range" if index < 0 || index >= list_size 
    counter = 0
    temp_node = @head
    until counter == index
      temp_node = temp_node.link_next
      counter += 1
    end
    temp_node.value
  end

  def index_of(value) #returns corensopnding index of given data of the list
    return nil if @head == nil
    counter = 0
    temp_node = @head
    loop do
      return counter if temp_node.value == value
      counter += 1
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    nil
  end
  #string representation of DCLL
  def to_s() #string representation with arrow pointers
    return puts "list is empty" if @head == nil
    #in string container first display value of last element, for checking up link correctness
    string = "[tail(#{@head.link_prev.value})] <-> " 
    temp_node = @head #then loop until through all elements
    loop do 
      string += "#{temp_node.value} <-> " #append temp node value with arrow to string container
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    #display string and append head cheak, temp node must be same value as head
    puts string + "[head(#{temp_node.value})]" 
  end

  def print_from_head() #print elements in list without arrow representation
    return puts "list is empty" if @head == nil
    temp_node = @head
    loop do
      print "#{temp_node.value} " #first print then move pointer
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    puts
  end

  def print_from_tail() #print elements in revers without arrow representation
    return puts "list is empty" if @head == nil
    temp_node = @head
    loop do
      temp_node = temp_node.link_prev #first move pointer then print
      print "#{temp_node.value} "
      break if temp_node == @head
    end
    puts
  end

  def print_recursive(start = @head, current = start) #print elements using recurion
    #to print with recursion in DCLL we need two patameters, start pointer and 
    #current position pointer (same first call, so we can print first element).
    return puts "list is empty" if start == nil
    print "#{current.value} " #print current element value
    current = current.link_next #then, increment current element
    if start != current #until current is diff from head call method recursive
      print_recursive(start, current)
    else #if current pointer == @head put new line for command line display
      puts
    end
  end

  def print_recursive_reverse(start = @head, current = start) #print elements in reverse order using recurion
    return puts "list is empty" if start == nil
    current = current.link_prev #first move pointer then print
    print "#{current.value} "
    if start != current
      print_recursive_reverse(start, current)
    else
      puts
    end
  end
  #reverse list
  def reverse_list() #reverse DCLL using iteration
    return @head if @head == nil || @head.link_next == @head
    temp_node = @head
    prev_node = nil #create referce for previuos node
    loop do
      next_node = temp_node.link_next #save list from next node
      prev_node = temp_node.link_prev #save list from previous node
      temp_node.link_prev = temp_node.link_next #swap links for current node
      temp_node.link_next = prev_node #swap links for current node
      temp_node = next_node #increment node in the loop
      break if temp_node == @head 
    end
    @head = prev_node.link_prev #reassign head
  end

  def reverse_list_recursive(start = @head, current = start) #reverse DCLL using recursion
    next_node = current.link_next
    prev_node = current.link_prev
    current.link_prev = current.link_next
    current.link_next = prev_node
    current = next_node
    #another approuch
    #store_node = current.link_next
    #current.link_next = current.link_prev
    #current.link_prev = store_node
    #current = current.link_prev
    if start == current
      return @head = prev_node.link_prev
      #return @head = current.link_next
    else
      reverse_list_recursive(start, current)
    end
  end
  #sorting
  def insertion_sort() #time compelexity O(n2)
    #insertions sort is natural for DCLL because we can traverse in both directions 
    return @head if @head == nil || @head.link_next == @head
    temp_node = @head.link_next
    until temp_node == @head
      current_node = temp_node
      until current_node == @head
        if current_node.value <= current_node.link_prev.value
          store_value = current_node.value
          current_node.value = current_node.link_prev.value
          current_node.link_prev.value = store_value
        end
        current_node = current_node.link_prev
      end
      temp_node = temp_node.link_next
    end
  end

  def merge_sort(list = @head) ##time compelexity O(n log n) but needs 2 helper methods divide and merge
    return nil if list == nil
    return list if list.link_next == list
    left_part, right_part = divide_list(list)
    left = merge_sort(left_part)
    right = merge_sort(right_part)
    @head = merge_sorted_lists(left, right)
    #@head assigment is needed beacuse divide_list method has changed @head
  end

  def divide_list(list = @head) #split list in two halfs
    if list == nil || list.link_next == list
      left = list #if list is empty both halfs are nil
      right = nil #if list has 1 element, left half is list, and right is nil
      return [left, right]
    end
    #if list has more then 1 element, find mid element using slow/fast pointer
    slow_pointer = list #when loop finish this is pointer for mid point of the list
    fast_pointer = list
    while fast_pointer.link_next != list && fast_pointer.link_next.link_next != list
      fast_pointer = fast_pointer.link_next.link_next #fast going 2 elements
      slow_pointer = slow_pointer.link_next #slow going 1 element
    end
    tail_node = list #reference to last element for reconnecting right half list
    until tail_node.link_next == list
      tail_node = tail_node.link_next
    end
    left = list
    right = slow_pointer.link_next
    left.link_prev = slow_pointer
    slow_pointer.link_next = left
    #useing tail node we easy can finish circle for right half
    right.link_prev = tail_node
    tail_node.link_next = right
    [left, right]
  end

  def merge_sorted_lists(left, right) #combine two sorted list in one
    new_node = Node.new(0) #create new node with some value, here is zero used
    result_node = new_node #reference to new_node to memorize last element
    left_node = left #reference to left list to memorize last element in left
    right_node = right #reference to right list to memorize last element in right
    loop do#first loop goes until one of the list reach end
      if left_node.value <= right_node.value
        result_node.link_next = left_node
        left_node.link_prev = result_node
        left_node = left_node.link_next
        result_node = result_node.link_next
        break if left_node == left
      else
        result_node.link_next = right_node
        right_node.link_prev = result_node
        right_node = right_node.link_next
        result_node = result_node.link_next
        break if right_node == right
      end
    end
    #in this state method is reached last element in ONE list, other has some leftover values
    loop do #if left part has leftovers then loop over left and attach elements to result node
      result_node.link_next = left_node
      left_node.link_prev = result_node
      left_node = left_node.link_next
      result_node = result_node.link_next
      break if left_node == left
    end
    #if right part has leftovers then loop over right and attach elements to result node
    loop do
      result_node.link_next = right_node
      right_node.link_prev = result_node
      right_node = right_node.link_next
      result_node = result_node.link_next
      break if right_node == right
    end
    #after both list has reach last element, we must complete circle
    result_node.link_next = new_node.link_next #after both list has reach last element, we must complete circle
    new_node.link_next.link_prev = result_node
    new_node.link_next
  end

  def delete_dupicate_sorted()
    return @head if @head == nil || @head.link_next == @head
    temp_node = @head
    loop do
      #first break condition if we have reached end of list or all elements are same
      break if temp_node.link_next == @head
      if temp_node.value == temp_node.link_next.value
        #bypass next node
        store_node = temp_node.link_next.link_next
        temp_node.link_next = store_node
        store_node.link_prev = temp_node
      else #if conditio not met traverse one element
        temp_node = temp_node.link_next
        break if temp_node == @head
      end
    end
  end

  def delete_dupicate_unsorted()
    return @head if @head == nil || @head.link_next == @head
    temp_node = @head
    loop do  #needs 2 loops to keep value outer loop node
      current_node = temp_node
      loop do
        break if current_node.link_next == @head
        if temp_node.value == current_node.link_next.value
          #bypass next node
          store_node = current_node.link_next.link_next
          current_node.link_next = store_node
          store_node.link_prev = current_node
        else
          current_node = current_node.link_next
          break if current_node == @head
        end
      end
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
  end
end
#for better understending read all liked list data structure files :P
list = CircularDoublyLinkedList.new()

list.push('C')
list.push('C')
list.push('B')
list.push('C')
list.push('C')
list.push('A')
list.push('C')
list.push('B')
list.push('C')
list.push('C')
list.push('A')
list.push('C')
list.push('C')


list.to_s()
list.delete_dupicate_unsorted()
list.print_from_head()
list.print_from_tail()





