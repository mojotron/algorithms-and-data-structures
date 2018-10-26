class LinkedList
  #linked list needs halper class that represets elements
  class Node #single element in LL is node
    attr_accessor :value, :link
    def initialize(value) #node has 2 variables
      @value = value #to contain value (data)
      @link = nil #and link to next element in LL
    end
  end
  #when LL is created its empty
  attr_accessor :head
  def initialize() 
    @head = nil #head variable is pointer, it's point to first element in the LL
  end
  #list size, helpfull in element deletion and insertion
  def list_size()
    counter = 0
    temp_node = @head #start traversting from first elemnt
    until temp_node == nil #stop when reach end of list
      temp_node = temp_node.link #step though list with link variable
      counter += 1
    end
    counter
  end
  #adding elements to LL
  def push(value) #adding element at the end of LL
    new_node = Node.new(value) #create new node
    return @head = new_node if @head == nil #if head is nil(list is empty) new node becomes head
    #if list is not empty, we must traverse to last element in the list 
    temp_node = @head #starting from the head
    until temp_node.link == nil #last element in the list is element whit link pointing to nil
      temp_node = temp_node.link #traversing through list using link variable
    end
    temp_node.link = new_node #to append node we assign new node ad last nodes link variable
  end

  def unshift(value) #adding element at the beginning of LL
    temp_head = Node.new(value) #create new node as teporarly head
    temp_head.link = @head #assing current head to temp head link, now temp link has all elements connected
    @head = temp_head #temp head is now current head
  end

  def insert_at(value, index) #adding element at nth position of LL
    #first case LL is empty or inserting at 0 position, use unshift method
    return unshift(value) if @head == nil || index == 0
    #second case index == size => points to last element, use push method 
    #(NOTE: if index is greater then size, inserting will be executed and element will be added)
    return push(value) if self.list_size() <= index
    #last case if index points somewhere between frist and last element
    counter = 1 #start counting from 1 (to insert node before element on nth position
    #(to insert node after element on nth position change counter to 0 initiali))
    temp_node = @head
    until counter == index #traverse through list from head until we reach condition
      temp_node = temp_node.link
      counter += 1
    end
    new_node = Node.new(value) #first create new node
    new_node.link = temp_node.link #second take link from temp node and assign it to new node link
    temp_node.link = new_node #last link temp node to new node
  end
  #deleting elements to LL
  def pop() #delete last element in the LL
    return nil if @head == nil #if list is empty return nil
    return @head = nil if self.list_size == 1 #list has 1 element(head) assign head to nil
    temp_node = @head #if list has more then 1 element, travres till last element
    #stop conditon is when second element from current link to nil, means that first
    #from current is last element in the list
    until temp_node.link.link == nil 
      temp_node = temp_node.link
    end
    temp_node.link = nil #cat the link with last element by assigning previous link to nil
  end

  def shift() #delete first element in the LL
    @head = @head.link #reasign head to heads link, cuts of heads value
  end

  def delete_at(index) #delete element at nth position in the LL
    list_size = self.list_size()
    return nil if (list_size) < index #***
    #first case, list is empty or deleting first element(using shift method)
    return self.shift() if list_size == 1 || index == 0
    #second case, index == list size => delete last element(useing pop method)
    #(NOTE: if index is greater then list size deleting will not be executed, 
    #last element will not be deleted)***
    return self.pop() if (list_size - 1) == index 
    #last case if index points somewhere between frist and last element
    counter = 1
    temp_node = @head #traverse from head till position of element we want to delete
    until counter == index
      temp_node = temp_node.link
      counter += 1
    end
    #cut of element by bypassing link to previous element link to next element in list
    temp_node.link = temp_node.link.link 
  end
  #string representation of LL
  def to_s() #classical with traversing
    string = '' #string container
    temp_node = @head #traversing start
    until temp_node == nil #traversing until last element
      #update string container with intepolation of element value and arrow pointin next element
      string += "#{temp_node.value} -> " 
      temp_node = temp_node.link
    end
    puts string + 'nil' #last element in LL is nil, if list is empty only nil is printed
  end

  def print_recursive(list = @head) #print elements using recursion
    #returns same output as to_s method
    if list == nil #base case
      puts 'nil' #base case reached, puts nil ass last link
      return #exit, there is no opetations in stack memory
    end
    print "#{list.value} -> " #print before recursive call, before funtion go to stack
    print_recursive(list.link) #call, itself until link == nil   
  end

  def print_reverse_recursive(list = @head) #print elements using recursion in reverse order
    #returns elements in reversto print with last elemet nil adn new line
    #call with Karnel p function like "p list.print_reverse_recursive()"
    if list == nil
      return #entering stack memory
    end 
    print_reverse_recursive(list.link)
    print "#{list.value} -> "#print after recursive call, LIFO
  end
  #searching for element 
  def search(value) #returns node with corenspondig data, nil if not found
    return nil if @head == nil 
    temp_node = @head #traverse throuhg list starting from head
    until temp_node == nil
      #if searched value == current node(temp) value, return node
      return temp_node if temp_node.value == value 
      temp_node = temp_node.link
    end
    nil #nil if traversing reach end, and value did not found
  end

  def contains?(value) #return true / false if data(value) is in thr list
    return false if @head == nil #diff between search method is contais return true/false
    temp_node = @head #traverse throuhg list starting from head
    until temp_node == nil
      #if searched value == current node(temp) value, return true
      return true if temp_node.value == value
      temp_node = temp_node.link
    end
    false #false if traversing reach end, and value did not found
  end

  def value_at(index) #return corenspondig data at given index of the list
    list_size = self.list_size()
    #return nil if list is empty or index is bigger then list size
    return nil if list_size == 0 || index >= list_size
    counter = 0
    temp_node = @head #traverse from head until element at position(index)
    until counter == index
      temp_node = temp_node.link
      counter += 1
    end
    temp_node.value #return value of corensponding element
  end

  def index_of(value) #returns corensopnding index of given data of the list
    counter = 0 #loop counter
    temp_node = @head #start traversing from head
    until temp_node == nil
      #if value found return counter which is index of searched value
      return counter if temp_node.value == value
      temp_node = temp_node.link
      counter += 1 #increment counter if not found
    end
    nil #nil if traversing rach end and value did not found
  end
  #reversing LL
  def reverse_list() #reverse list with iteration
    return nil if @head == nil
    temp_node = @head
    prev_node = nil #to reverse list, we need last value in LL which is nil
    until temp_node == nil
      #first take over link from temp node and save it in next node variable
      next_node = temp_node.link 
      #next, break link current from temp element and link it to previosu node
      #now, current first element is last element
      temp_node.link = prev_node  
      #next, move previous pointer 1 elemet
      prev_node = temp_node
      #last, next node is current node we traverse
      temp_node = next_node
    end
    #after reconnection of links, reasign @head 
    @head = prev_node #we need head to travers the list, this is very important
  end

  def reverse_list_recursive(list = @head) #reverse list using recursion
    #base case, when we travers to last element, reasign it to @head, last elemet is first now
    return @head = list if list.link == nil
    #call recursion with next element, until we get last
    reverse_list_recursive(list.link)
    #temp is next node, this is in stack memory so this is previous node in original LL
    temp_node = list.link
    #next reverse link
    temp_node.link = list
    #cut the link in original list and link to last element in LL (nil)
    list.link = nil
  end
  #sorting elements
  def bubble_sort() #sorting in average complexity of О(n2)
    #using bubble sort, its natural choice because linked list go from left to right
    temp_node = @head
    
    until temp_node == nil 
      next_node = temp_node.link
      until next_node == nil 
        if temp_node.value > next_node.value
          #swap variable if current node(pointer -> temp node) in outer loop is greater then
          #current node in inner(poinrt -> next_node) loop
          swap_variable = temp_node.value
          temp_node.value = next_node.value 
          next_node.value = swap_variable
        end
        next_node = next_node.link
      end     
      temp_node = temp_node.link
    end
  end

  def merge_sort(list = @head)
    #base case return element when list is of size 1
    return list if list == nil || list.link == nil
    #else, split list in 2 parts
    left_part, right_part = divide_list(list)
    #for separate part call recursive method untill base case is accompished
    left = merge_sort(left_part)
    right = merge_sort(right_part)
    #after all recursion calls are done, reassemble list from stack memory
    @head = merge_sorted_lists(left, right)
    #@head assigment is needed beacuse divide_list method has changed @head 
  end

  def divide_list(list = @head)
    #in case list is empty or has 1 element
    if list == nil || list.link == nil
      left = list #left part of the list is @head or nil
      right = nil #right part in both cases is nil
      return [left, right] #return array containg both parts
    end
    #in case LL is greater then 1 element, travers through list with 2 pointers
    slow_pointer = list #slow is going 1 step
    fast_pointer = list.link #fast is going 2 steps,starting from second element
    #fast is 2 times faster, that means when fast is over with traversing,
    #slow points to middle of the list and marks spot for divideing LL in 2 parts left and right
    until fast_pointer == nil
      fast_pointer = fast_pointer.link #fast takes frist step
      if fast_pointer != nil #if fast is not reach end of LL
        slow_pointer = slow_pointer.link #slow makes step
        fast_pointer = fast_pointer.link #fast takes additional step
      end
    end
    left = list #left part starts from beginnig of the LL
    right = slow_pointer.link #right part statrs of the middle(slow_pointer marks middle)
    slow_pointer.link = nil #last we need to cut of middle so left is not whole LL
    [left, right] #return array containg both parts
  end

  def merge_sorted_lists(left, right) #merge together 2 sorted lists
    #to sort 2 LL we need new node in which we will save result of comparisons
    #@head node value can be any value, we will take new_node.link as return value
    new_node = Node.new(0) #we need reference, becasue new node is only temp in stack memory
    result_node = new_node #reference to new_node
    #run loop as long as one LL traversal till end
    while left != nil && right != nil 
      #comapare value in first elements of LLs
      if left.value <= right.value #if left element <= right
        result_node.link = left #link next element in result to left LL
        left = left.link #move one element foward in left LL
      else #if left element >= right
        result_node.link = right #link next element in result to right LL
        right = right.link #move one element foward in right LL
      end #after comaprison is over
      result_node = result_node.link #move one element foward in result LL
    end 
    #append list which is not run till end of the list
    result_node.link = (left == nil) ? right : left
    #return result from second element, because first element is element from creating new node
    new_node.link 
  end

  def delete_dupicate_sorted() 
    #if list is sorted we only need to travers LL once, O(n) linear time
    return @head if @head == nil || @head.link == nil
    temp_node = @head
    until temp_node.link == nil #traversing til last element with value
      if temp_node.value == temp_node.link.value
        #store next node for traversal, in this case not next because we will delete next,
        #but second form current or next->next
        next_node = temp_node.link.link
        #cut of temp_node(current) link
        temp_node.link = nil
        #attach in that place next->next node, so we skip 1 node, a cant continue traversal
        temp_node.link = next_node
        #basically this 3 steps are -> temp_node.link = temp_node.link.link
      else
        #traversal only if deletion accure
        temp_node = temp_node.link
      end
    end
  end

  def delete_dupicate_unsorted()
    #using 2 loops, O(n2) time
    return @head if @head == nil || @head.link == nil
    temp_node = @head
    until temp_node == nil
      current_node = temp_node #refrence to temp node
      until current_node.link == nil
        #compare value of temp node and next element in inner loop
        if temp_node.value == current_node.link.value
          #if elements are same skip next element with linking current to second next
          current_node.link = current_node.link.link
          #another implementation:
          #next_node = current_node.link.link
          #current_node.link = nil
          #current_node.link = next_node
        else
          #if elements are not same travers one element foward
          current_node = current_node.link
        end
      end
      #after finish inner loop move outer pointer one element
      temp_node = temp_node.link
    end
  end
end

list = LinkedList.new
list.push('A')
list.push('B')
list.push('A')
list.push('C')
list.push('C')
list.push('A')
list.push('C')
list.push('A')
list.push('C')
list.push('A')
list.push('A')
list.to_s()
list.delete_dupicate_unsorted()
list.to_s()


#list.reverse_list_recursive()
#list.to_s()
#l, r = list.divide_list()
#p list.merge_sorted_lists(l,r)

