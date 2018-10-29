class CircularLinkedList
  #helper class Node for representing single element in the CLL
  class Node #Node is same as Node in Simple LL, 2 variables:
    attr_accessor :value, :link
    def initialize(value)
      @value = value #for holding data
      @link = nil #for holding link to the next element in the list
    end
  end
  #diff between LL and CLL is that last element linkes to the first, making circle
  attr_accessor :head
  #when creating new DLL its created as empty, head is pointer to first element, atm nil
  def initialize()
    @head = nil
  end
  #size of CLL, getting number of elements in the list is very helpfull (inserting, deleting...)
  def list_size()
    counter = 0
    return counter if @head == nil
    temp_node = @head 
    loop do
      #while loop must be used to count first element, if we exit condition is before 
      #first iteration (while temp_node != @head) loop will treminate there
      counter += 1
      temp_node = temp_node.link
      break if temp_node == @head
    end
    counter
  end
  #adding elements to CLL
  def push(value)#appending element to the END of the CLL
    new_node = Node.new(value) #create new element
    #if list is empty, new node becomes head
    if @head == nil
      @head = new_node
      @head.link = @head #to colse the circle head must point to itself
      return
    end
    #in case list is not empty, first traversal to the last element in the list
    temp_node = @head
    until temp_node.link == @head #last element in the list is one pointing to the head
      temp_node = temp_node.link
    end
    new_node.link = @head #first, connect new last element with first element to coles circle
    temp_node.link = new_node #second, connect last element in the list with new last(new_node)
  end

  def unshift(value) #adding element at the beginning of the CLL
    new_head = Node.new(value) #creat new element, which will be new head in the CLL
    #case list is empty, head is new element, and to colse circle link it to itself
    if @head == nil
      @head = new_head
      @head.link = @head
    end
    #in case list is not empty, first we must traversal until we reach last element
    temp_node = @head
    until temp_node.link == @head
      temp_node = temp_node.link
    end
    #after loop has traversal to the last element, link it to the new head, to close circle
    temp_node.link = new_head
    #now link new head to the current head to take its content
    new_head.link = @head
    #last reasigh head to new head
    @head = new_head
  end

  def insert_at(value, index) #adding element at nth position of DLL
    list_size = self.list_size() #use number of elements for conditions
    return puts "out of range" if index < 0 || index > list_size
    #case, list is empty or isertions is at first position use unshift method
    return self.unshift(value) if @head == nil || index <= 0 
    #case, index points to last element (between last -> head) use push method
    return self.push(value) if index == list_size
    #case, add element somwhere between first and last element
    temp_node = @head
    counter = 1 #start counting from 1 (to insert node before element on nth position
    #(to insert node after element on nth position change counter to 0 initiali))
    until counter == index
      temp_node = temp_node.link
      counter += 1
    end
    new_node = Node.new(value) #create new node
    #store value of next element along with all its links, linking new node to it
    new_node.link = temp_node.link
    #link temp node to new node
    temp_node.link = new_node
  end
  #deleting elements from CLL
  def pop() #delete last element from the CLL
    return nil if @head == nil #empty list
    return @head = nil if @head.link == @head #list has 1 element
    temp_node = @head 
    #in case that list has more then 1 element, move pointer to second element from last elemet
    until temp_node.link.link == @head
      temp_node = temp_node.link
    end
    #when pointer is placed, connect links that connects last element with head
    temp_node.link = @head
  end

  def shift() #delete first element from the CLL
    return nil if @head == nil #empty list
    return @head = nil if @head.link == @head #list has 1 element
    temp_node = @head
    #in case that list has more then 1 element, move pointer to the last element in the list
    until temp_node.link == @head
      temp_node = temp_node.link
    end
    #connect last element with second element (head->next via link)
    temp_node.link = @head.link
    @head = @head.link #second element is new head
  end

  def delete_at(index) #delete element from the list at nth position
    list_size = self.list_size()
    return puts "out of range" if index < 0 || index >= list_size
    #if list has 1 element or deleting first element use shift method
    return self.shift() if list_size == 1 || index == 0
    #if last element is to be deleted use pop method
    return self.pop() if (list_size - 1) == index
    temp_node = @head
    counter = 1
    #move pointer before element we want to delete
    until counter == index
      temp_node = temp_node.link
    end
    temp_node.link = temp_node.link.link #by pass next element with second from next 
  end
  #string repersentation of CLL
  def to_s() ##representing list of elements link as arrow
    return puts "list is empty" if @head == nil
    string = '' #container for build string
    temp_node = @head #set pointer at the strat of the list
    #while loop must be used, if we exit condition is before first iteration (while temp_node != @head)
    #loop will treminate there, no mether how meny elements there is
    loop do 
      string += "#{temp_node.value} -> " #now we can use value from first element
      temp_node = temp_node.link  #move pointer to next element
      break if temp_node == @head #exit loop if condition is true
    end
    #part after plus sign is auto check if loop is circular, temp is head after exiting loop
    puts string + "[head(#{temp_node.value})]"
  end

  def print_recursive(start = @head, current = @head) #print elements using recursion
    #to print with recursion in CLL we need to patameters, start pointer and 
    #current position pointer (same first call, so we can print first element).
    print "#{current.value} -> "
    current = current.link #move pointer to next element in te current list reference
    if current != start #until we reach last elemnt which points to head, do recursive calls
      print_recursive(start, current)
    end
    #to print last element pointer to head, ad circular check up
    if current == start
      puts "[head(#{current.value})]"
    end
  end

  def print_reverse_recursive(start = nil, current = @head) #print elements using recursion in reverse order 
    #we need also 2 parameter to use recursion, but first call we use nil as start so we
    #can skip first condition 
    if current == start
      return print "[head(#{current.value})]"
    end
    print_reverse_recursive(start = @head, current.link)
    print " <- #{current.value}" 
  end

  def search(value) #returns node with corenspondig data, nil if not found
    #while do loop would make error so check before if list is empty,
    return nil if @head == nil 
    temp_node = @head
    loop do
      #wile do, to check first element
      return temp_node.value if temp_node.value == value
      temp_node = temp_node.link
      break if temp_node == @head
    end
    nil
  end

  def contains?(value) #return true / false if data(value) is in thr list
    return false if @head == nil
    temp_node = @head
    loop do
      return true if temp_node.value == value
      temp_node = temp_node.link
      break if temp_node == @head
    end
    false
  end

  def value_at(index) #return corenspondig data at given index of the list
    list_size = self.list_size()
    return puts "out of range" if index < 0 || index >= list_size
    temp_node = @head
    counter = 0
    until counter == index
      temp_node = temp_node.link
      counter += 1
    end
    temp_node.value
  end

  def index_of(value) #returns corensopnding index of given data of the list
    return nil if @head == nil
    temp_node = @head
    counter = 0
    loop do
      return counter if temp_node.value == value
      counter += 1
      temp_node = temp_node.link
      break if temp_node == @head
    end
    nil
  end 

  def reverse_list()
    return @head if @head == nil || @head.link == @head
    temp_node = @head
    prev_node = nil
    loop do
      next_node = temp_node.link #store list from current element till end
      temp_node.link = prev_node #cut, link from rest of list and connect to prev temp variable
      prev_node = temp_node #move prev for one element
      temp_node = next_node #move one element using stored value in next ode
      break if temp_node == @head
    end
    @head.link = prev_node #after swaping links, finish circle by attaching head to last element
    @head = prev_node #make last element first element
  end

  def reverse_list_recursive()
  end

  def bubble_sort() #sorting in average complexity of О(n2)
    #using bubble sort, its natural choice because linked list go from left to right
    return @head if @head == nil || @head.link == @new_head
    outher_node = @head
    #using 2 while do loop so we can check first value before loop condition
    loop do
      inner_node = outher_node
      loop do
        if outher_node.value > inner_node.value
          store_value = inner_node.value
          inner_node.value = outher_node.value
          outher_node.value = store_value
        end
        inner_node = inner_node.link
        break if inner_node == @head
      end
      outher_node = outher_node.link
      break if outher_node == @head
    end
  end

  def merge_sort(list = @head)
  end

  def divide_list(list = @head)
  end

  def merge_sorted_lists(left, right)
  end

  def delete_dupicate_sorted()
  end

  def delete_dupicate_unsorted()
  end

end

list = CircularLinkedList.new()
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
list.bubble_sort()
list.to_s()
list.reverse_list()
list.to_s()
