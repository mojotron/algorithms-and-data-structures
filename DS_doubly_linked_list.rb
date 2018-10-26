class DoublyLinkedList
  #helper class Node for representing single element in the DLL
  class Node #node in DLL has 3 variables
    attr_accessor :value, :link_next, :link_prev
    def initialize(value)
      @value = value #value for storing actual data of the element
      @link_next = nil #variable for linking to the next element in the DLL
      @link_prev = nil #Variable for linking to the previous element in the DLL (only diff from singly LL)
    end
  end
  #initializing actual DLL classs
  attr_accessor :head
  #when creating new DLL its created as empty, head is pointer to first element, atm nil
  def initialize() 
    @head = nil 
  end
  #size of DLL, getting number of elements in the list is very helpfull (inserting, deleting...)
  def list_size() #iterativ approch O(n) time compexity
    counter = 0 
    temp_node = @head #start traversing the list from first element(head)
    until temp_node == nil #traverse until loop reach end of the list
      temp_node = temp_node.link_next #iterate using link to the next element
      counter += 1 #increment counter
    end
    counter
  end
  #adding elements to DLL
  def push(value) #appending element to the END of the DLL
    new_node = Node.new(value) #create new element
    #if DLL is empty, new node becomes head
    return @head = new_node if @head == nil
    #if DLL is not empty, first traversal until last element in the list
    temp_node = @head
    #if link_next of current element points to nil, current element is last in the list
    until temp_node.link_next == nil  
      temp_node = temp_node.link_next
    end
    new_node.link_prev = temp_node #new node prev link points to previous element 
    temp_node.link_next = new_node #last element is appended by connecting temp link to new wlwmwnt
  end

  def unshift(value) #adding element at the beginning of DLL
    new_head = Node.new(value) #creat new node, new_head
    return @head = new_head if @head == nil
    @head.link_prev = new_head #connect prev link of head to new head
    new_head.link_next = @head #connect next link of new head to head
    @head = new_head #reasign head pointer to new head
  end

  def insert_at(value, index) #adding element at nth position of DLL
    #if list is empty we wnat to insert at first place, use unshift method
    return self.unshift(value) if @head == nil || index == 0
    #use push to append element if index greater then list_size
    return self.push(value) if index >= self.list_size()
    #if index points between 2 elemnts 
    temp_node = @head
    counter = 1 #start counting from 1 (to insert node before element on nth position
    #(to insert node after element on nth position change counter to 0 initiali))
    until counter == index #move pointer to correct possition with classic traversal
      temp_node = temp_node.link_next
      counter += 1 #update counter, loop need stop condition
    end
    new_node = Node.new(value)
    #store value of next element along with all its links, linking new node to it
    #if we do not do this we cut off and lose rest of DLL
    new_node.link_next = temp_node.link_next
    #connect next node with new node via previous link
    temp_node.link_next.link_prev = new_node
    #now connect temp node with new node and insert it betewwn new and next
    temp_node.link_next = new_node
    new_node.link_prev = temp_node
  end
  #string representation of DLL
  def to_s() #representing list of elements with both links (next and prev)
    return puts 'list is empty' if @head == nil
    string = 'nil <- ' #container, first element prev link points to nil
    temp_node = @head #traverse through whole DLL O(n)
    until temp_node == nil 
      string += "#{temp_node.value}"  #for every elememt update string container with value 
      if temp_node.link_next != nil #if element is not last
        string += " <-> " #update and string container arrow representation
      end
      temp_node  = temp_node.link_next #traversing to next element
    end
    puts string + ' -> nil' #append arrow pointing to nil to last element
  end 

  def print_from_head() #print element from first till last element, without arrows
    return puts 'list is empty' if @head == nil
    string = ''
    temp_node = @head
    until temp_node == nil
      string += "#{temp_node.value} " #update container with current element value
      temp_node = temp_node.link_next
    end
    puts string.chomp #print container without space at the end
  end

  def print_from_tail() ##print element from last till first element, without arrows
    return puts 'list is empty' if @head == nil
    string = ''
    temp_node = @head
    until temp_node.link_next == nil
      temp_node = temp_node.link_next
    end
    #after last element is reached, ne loop starts from it using previous element link
    until temp_node == nil #this algoritham is O(n2)
      string += "#{temp_node.value} "
      temp_node = temp_node.link_prev
    end
    puts string.chomp
  end
  #deleting elements to DLL
  def pop() #delete last element in the DLL
    return nil if @head == nil 
    return @head = nil if @head.link_next == nil
    #in case that list has more then 1 element, move pointer to second element from last elemet
    temp_node = @head #using condition node->next->next, this give room for cutting links
     #node->next->nil we cant cut prev link because node is nil
    until temp_node.link_next.link_next == nil
      temp_node = temp_node.link_next
    end
    #when pointer is placed, cut links that connects last element
    temp_node.link_next.link_prev = nil #first 
    temp_node.link_next = nil
  end

  def shift() #delete first element in the DLL
    return nil if @head == nil
    return @head = nil if @head.link_next == nil
    @head = @head.link_next #move head to next element
    @head.link_prev = nil #cut link from head(now first element), must point to nil
  end

  def delete_at(index) #delete element at nth position in the DLL
    list_size = self.list_size() #helper for range condition
    return puts "out of range" if index < 0 || index >= list_size
    #if list has 1 element or deleting first element use shift method
    return self.shift() if list_size == 1 || index == 0 
    #if last element is to be deleted use pop method
    return self.pop() if (list_size - 1) == index
    counter = 1
    temp_node = @head
    until counter == index
      temp_node = temp_node.link_next
      counter += 1
    end
    #move counter before element to be deleted, store next->next element from pointer
    #so next element(one to be deleted) can be bypassed
    store_node = temp_node.link_next.link_next #store element, and reconnect it
    store_node.link_prev = temp_node #link new next elemnt to temp node(pointer)
    temp_node.link_next = store_node #and link temp node to new next element
    #if element is not stored, and we go directily bypass, rest of list will be cut of,
    #and be gone from memory, no referece and data is lost
  end
  #searching for element 
  def search(value) #returns node with corenspondig data, nil if not found
    temp_node = @head
    until temp_node == nil #traverse through list
      return temp_node if temp_node.value == value #if value is find return node
      temp_node = temp_node.link_next
    end
    nil #if not found return nil O(n)
  end

  def contains?(value) #return true / false if data(value) is in thr list
    temp_node = @head
    until temp_node == nil #traverse through list, return boolean if value is in list
      return true if temp_node.value == value
      temp_node = temp_node.link_next
    end
    false #also O(n)
  end

  def value_at(index) #return corenspondig data at given index of the list
    list_size = self.list_size()
    if index < 0 || index >= list_size
      puts "out of range" #case if index is not in range of the list size
      return nil
    end
    temp_node = @head
    counter = 0 #traverse througl list staring from head
    until counter == index #stop when counter is equal to index => index of element
      temp_node = temp_node.link_next
      counter += 1
    end
    temp_node.value #return data element contain not whole node O(n)
  end

  def index_of(value) #returns corensopnding index of given data of the list
    temp_node = @head
    counter = 0
    until temp_node == nil #if value is in the list return corensponding couner
      return counter if temp_node.value == value #that is index of searched value
      temp_node = temp_node.link_next
      counter += 1
    end
    nil #if traversing comes to end value is not in list and returns nil, O(n)
  end
  #reversing DLL
  def reverse_list() #reverse list with iteration
    return @head if @head == nil || @head.link_next == nil
    temp_node = @head
    prev_node = nil #container for previous list from temp node
    until temp_node == nil
      #first previuse becomes temp node prev link, save data
      prev_node = temp_node.link_prev
      #second switch current temp prev to point to next
      temp_node.link_prev = temp_node.link_next
      #third temp next link switch to point to previus element
      temp_node.link_next = prev_node
      #last increment loop, now links are swaped so next is prew and prev is next
      temp_node = temp_node.link_prev
    end
    #very important to reasign new head, rest of methods depend on it
    @head = prev_node.link_prev
  end

  def reverse_list_recursive(list = @head) #reverse list using recursion
    #first make swaping
    store_node = list.link_next #store next node
    list.link_next = list.link_prev #swap link next with link prev
    list.link_prev = store_node
    #then make recursive call
    if list.link_prev == nil
      return @head = list
    else
      #same as iterativ call, links are swaped so traversing go via prev link
      reverse_list_recursive(list.link_prev)
    end
  end
  #sorting elements
  def insertion_sort() #sorting algoritam vith worst case O(n2) time comlexity
    return @head if @head == nil || @head.link_next == nil
    #insertion sort is natural choice becaouse traversal can go in both direction
    outer_node = @head.link_next #start with second element, we compare elements right - left
    until outer_node == nil #first loop travers left to right
      inner_node = outer_node
      until inner_node.link_prev == nil #second(inner) travers from outher node right - left
        #compare current node with rest of nodes on the left in the DLL
        if inner_node.value < inner_node.link_prev.value #swap values if condition is true
          store_value = inner_node.value
          inner_node.value = inner_node.link_prev.value
          inner_node.link_prev.value = store_value
        end
        inner_node = inner_node.link_prev
      end
      outer_node = outer_node.link_next
    end
  end

  def merge_sort(list = @head) #sorting algoritam vith worst case O(n log n) time comlexity
    if list.link_next == nil #base case, list size of 1 element
      return list
    end
    left_part, right_part = divide_list(list) #dived list
    left = merge_sort(left_part) #divide left part ot the listuntil base case
    right = merge_sort(right_part) #divide right of the list part until base case
    @head = merge_sorted_lists(left, right) #last, combain results and asign to head
  end
  
  def divide_list(list = @head)
    #if list is empty or has 1 elemet
    if list == nil || list.link_next == nil 
      left = list #left half is element or nil
      right = nil #right side is nil
      return [left, right] #return array with left and right parts of DLL
    end
    #if list is bigger then 1 element traversal using 2 pointers
    slow_pointer = list #going 1 element at the time
    fast_pointer = list.link_next #going 2 elements at the time
    #when fast hit end of the list, slow points the middle because is 2 times slower
    until fast_pointer == nil
      fast_pointer = fast_pointer.link_next #fast takes frist step
      if fast_pointer != nil #if fast is not reach end of LL
        fast_pointer = fast_pointer.link_next #slow makes step
        slow_pointer = slow_pointer.link_next #fast takes additional step
      end
    end
    left = list #left part start at head of original list
    right = slow_pointer.link_next #right part starts from middle of the list
    slow_pointer.link_next = nil #cut of rest of the list
    right.link_prev = nil #cut of rest of the list
    [left, right]
  end

  def merge_sorted_lists(left, right)
    new_node = Node.new(0) #we need reference, becasue new node is only temp in stack memory
    result_node = new_node #reference to new_node
    #run loop as long as one DLL traversal until end
    while left != nil && right != nil 
      #comapare value in first elements of DLLs
      if left.value <= right.value #if left element <= right
        result_node.link_next = left #link next element in result to left DLL
        left.link_prev = result_node #also, link new appended elemet vith prev link
        left = left.link_next #move one element foward in left DLL
      else #if left element >= right
        result_node.link_next = right #link next element in result to right DLL
        right.link_prev = result_node #also, link new appended elemet vith prev link
        right = right.link_next #move one element foward in right DLL
      end #after comaprison is over
      result_node = result_node.link_next #move one element foward in result DLL
    end 
    #append list which is not run until end of the list
    if left == nil
      result_node.link_next = right
      right.link_prev = result_node
    end
    if right == nil
      result_node.link_next = left
      left.link_prev = result_node
    end
    #return result from second element, because first element is element 
    #from creating new node (0), but first cut it off
    new_node.link_next.link_prev = nil
    new_node.link_next

    #alternative way is using recursion
    #return right if left == nil
    #return left if right == nil
    #if left.value < right.value
    #  left.link_next = merge_sorted_lists(left.link_next, right)
    #  left.link_next.link_prev = left
    #  left.link_prev = nil
    #  return left
    #else
    #  right.link_next = merge_sorted_lists(left, right.link_next)
    #  right.link_next.link_prev = right
    #  right.link_prev = nil
    #  return right
    #end
  end

  #delete duplicate values
  def delete_dupicate_sorted() #time compexity O(n)
    return @head if @head == nil || @head.link_next == nil
    temp_node = @head
    until temp_node.link_next == nil
      #compare cuttent node with next one
      if temp_node.value == temp_node.link_next.value
        #if they have equal value, first save current->next->next
        store_node = temp_node.link_next.link_next
        #link prev link of store node if its a element in the list
        store_node.link_prev = temp_node if store_node != nil
        #connect current next link to new next element
        temp_node.link_next = store_node
      else
        temp_node = temp_node.link_next
      end
    end
  end

  def delete_dupicate_unsorted() #time compexity O(n2)
    #same mehanizam as sorted jut we using 1 more loop to keep track of element to compare
    return @head if @head == nil || @head.link_next == nil
    temp_node = @head
    until temp_node == nil
      inner_node = temp_node
      until inner_node.link_next == nil
        if temp_node.value == inner_node.link_next.value
          store_node = inner_node.link_next.link_next
          if store_node != nil
            store_node.link_prev = inner_node
          end
          inner_node.link_next = store_node
        else
          inner_node = inner_node.link_next
        end
      end
      temp_node = temp_node.link_next
    end
  end

end 
 

list = DoublyLinkedList.new()
list.push('A')
list.push('B')
list.push('A')
list.push('C')
list.push('B')
list.push('B')
list.push('C')
list.push('A')
list.push('C')
list.push('A')
list.push('C')
list.push('A')
list.push('A')
list.to_s()
list.merge_sort()
list.to_s()
#list.delete_dupicate_unsorted()
#list.to_s()
list.print_from_head()
list.print_from_tail()
 

