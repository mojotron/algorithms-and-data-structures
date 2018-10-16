class LinkedList

  class Node #helper class, node has to variables
    attr_accessor :value, :link
    def initialize(value)
      @value = value #for storing value of data
      @link = nil #for storing link to the next node in the list
    end
  end

  attr_accessor :head, :list_size
  def initialize #Linked list class is initialized with head node, and size of list
    @head = nil #until element is added head is nil
    @list_size = 0 #and size is 0
  end

  def to_s()
    string = ''
    temp_node = @head
    until temp_node == nil
      string += "#{temp_node.value} -> "
      temp_node = temp_node.link
    end
    puts string + 'nil'
  end

  def push(value) #add node at the end of the Linked List
    new_node = Node.new(value)
    #first check if linked list has any elements
    if @head == nil #if head is nil linked list has no elements
      @head = new_node #in that case @head is new node
      @list_size += 1 #node is created, add 1 to linked list size
      return #exit method, its done
    end
    #in case linked list is not empty, we must find first link with value nil (last element)
    temp_node = @head #to not mess up head, we are using temp variable vith head node
    until temp_node.link == nil #traversing until first nil link
      temp_node = temp_node.link #iterator, going from node to node via link
    end
    temp_node.link = new_node #when we are at last node, assigh its link to new_node
    @list_size += 1 #node is created, add 1 to linked list size
  end

  def unshift(value) #add element at the beginning ot the Linked List
    temp_head = Node.new(value) #create new node as temp head node, this will we new head node
    temp_head.link = @head #before that, head must be reassign to new head link variable
    @head = temp_head #only after that, we can sat new node to head
    @list_size += 1 #node is created, add 1 to linked list size
  end

  def insert_at(value, position)#add element at targeted position, this is where list_size is powerfull
    #first case, Linked list is empty or we want to add ellemet at first position (index 0)
    #we are going to use unshift method to add element
    return self.unshift(value) if (@list_size == 0) || (position == 0)
    #second case position is equal or greater to list size
    #we are going to use push method to add element 
    return self.push(value) if position >= @list_size
    #third case, adding node in beatween 2 existing nodes
    counter = 1 #start counting from first element, we inserting node before element at position
    #if counter is 0 insertion would be after element at position 
    #!!! in case we need insert_after, insert before methods for some reason
    temp_node = @head #strat traversing from first elemen (head)
    until counter == position #stop loop when counter is equal to position
      counter += 1
      temp_node = temp_node.link #looping path is via link variable
    end
    new_node = Node.new(value) #create new node
    new_node.link = temp_node.link #first take over link from temp node
    temp_node.link = new_node #then conecct temp node link to new node
    @list_size += 1
  end
  
  def pop() #delete last element from Linked list 
    if @list_size == 1
      @head = nil 
      @list_size = 0
      return
    end

    temp_node = @head
    counter = 2 #counter starts from 2 because we changing temp link(next node)to nil *
    until counter == @list_size 
      counter += 1
      temp_node = temp_node.link
    end
    temp_node.link = nil #*
    @list_size -= 1
  end

  def shift() #delete first element from Linked list
    @head = @head.link #just bypass head value
    (@head == nil) ? @list_size = 0 : @list_size -= 1
  end

  def delete_at(position) ##add element at targeted position
    return self.shift() if @list_size == 1 || position == 0
    return self.pop() if position >= @list_size 
    temp_node = @head
    counter = 1 #stats from 1 because we bypassing mid element
    until counter == position
      counter += 1
      temp_node = temp_node.link
    end      
    temp_node.link = temp_node.link.link
    @list_size -= 1
  end

  def value_at(position)
    return 'out of range' if position > @list_size || position < 0
    temp_node = @head
    counter = 0
    until counter == position
      counter += 1
      temp_node = temp_node.link
    end
    temp_node
  end

  def contains?(value)
    temp_node = @head
    until temp_node == nil
      return true if temp_node.value == value
      temp_node = temp_node.link
    end
    false
  end

  def find_position(value)
    temp_node = @head
    counter = 0
    until temp_node == nil
      return counter if temp_node.value == value 
      temp_node = temp_node.link
      counter += 1
    end
    nil
  end

  def reverse() #iteration way, swap links with help of 3 temp variables
    temp_node = @head #main iterating variable
    prev_node = nil #
    until temp_node == nil 
      next_node = temp_node.link #first, save value of next node
      temp_node.link = prev_node #link temp(current)node with previous instead of next node
      prev_node = temp_node #previous node becomes current node
      temp_node = next_node #and current node becomes next node so iteration dont break
    end
    @head = prev_node #last step is to reassign last previous node to head variable
  end

  def reverse_recursive(node = @head)
    if node.link == nil
      @head = node
      return
    end
    reverse_recursive(node.link)
    #temp is next node, this is in stack memory so this is previous node in original LL
    temp_node = node.link 
    temp_node.link = node #build link
    node.link = nil #cut link
  end

  def recursive_print(node = @head)
    return if node == nil 
    puts node.value
    recursive_print(node.link)
  end

  def reverse_recursive_print(node = @head)
    return if node == nil    
    reverse_recursive_print(node.link)
    puts node.value
  end

  def bubble_sort(temp_node = @head)
    until temp_node == nil
      swap = false
      next_node = temp_node.link
      until next_node == nil
        if temp_node.value > next_node.value
          temp_node.value, next_node.value = next_node.value, temp_node.value
          swap = true
        end
        next_node = next_node.link
      end
      break if swap == false
      temp_node = temp_node.link
    end
  end

  def split_list(list = @head)
    if list == nil || list.link == nil
      left = list
      right = nil
      return
    end
    slow_pointer = list
    fast_pointer = list.link
    while fast_pointer != nil
      fast_pointer = fast_pointer.link
      if fast_pointer != nil
        slow_pointer = slow_pointer.link
        fast_pointer = fast_pointer.link
      end
    end
    left = list
    right = slow_pointer.link
    slow_pointer.link = nil
    [left, right] 
  end

  def merge_lists(left, right)
    dummy_node = Node.new(0)
    current_node = dummy_node
    while left != nil && right != nil
      if left.value <= right.value
        current_node.link = left
        left = left.link
      else
        current_node.link = right
        right = right.link
      end
      current_node = current_node.link
    end
    current_node.link = (left == nil) ? right : left
    dummy_node.link
  end

  def merge_sort(list = @head)
    if list == nil || list.link == nil
      return list
    end
    left, right = split_list(list)
    x = merge_sort(left)
    y = merge_sort(right)
    merge_lists(x,y) #!!!!
  end

  def binary_search(value, list = @head)
    
  end

  def list_middle(list = @head)#same operations as split, but because better readability i'll break DRY
    if list == nil || list.link == nil
      return list
    end
    slow_pointer = list
    fast_pointer = list.link
    while fast_pointer != nil
      fast_pointer = fast_pointer.link
      if fast_pointer != nil
        slow_pointer = slow_pointer.link
        fast_pointer = fast_pointer.link
      end
    end
    slow_pointer #points to the middle node
  end
end

x = LinkedList.new
x.push(30)
x.unshift(25)
x.insert_at(10, 1)
x.push(12)
x.push(15)
x.to_s()
x.bubble_sort()
#x.to_s()
#x.head = x.merge_sort()
x.to_s()
p x.binary_search(150)

=begin
def merge(left, right)
    dummy_node = Node.new(0)
    current_node = dummy_node
    while left != nil && right != nil
      if left.value <= right.value
        current_node.link = left
        left = left.link
      else
        current_node.link = right
        right = right.link
      end
      current_node = current_node.link
    end
    current_node.link = (left == nil) ? right : left
    dummy_node.link
  end

  def split_up_list(temp_node = @head.clone)
    node = temp_node
    return node if node == nil
    slow = node
    fast = node
    while fast != nil && fast.link != nil
      fast = fast.link.link
      slow = slow.link
    end
    left = node 
    right = slow.link 
    slow.link = nil 
  end

   if left == nil
      return right
    elsif right == nil
      return left
    end
    result = Node.new(0)
    if left.value <= right.value
      result.link = merge_lists(left.link, right)
    else
      result.link = merge_lists(left, right.link)
    end
    result.list
=end