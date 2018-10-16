class Node #helper class for interpreting element in Linked List
  attr_accessor :value, :link

  def initialize(value) #inititalize with 2 variables
    @value = value #to store date we want to store in Linked List
    @link = nil #variable to point current node to the next node in Linked List
  end
end

class LinkedList 
  attr_accessor :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def to_s
    x = ''
    temp_node = @head
    while temp_node != nil
      x += "#{temp_node.value} -> "
      temp_node = temp_node.link
    end
    puts x + 'nil'
  end

  def value_at(position)
    return nil if position >= @size
    temp_node = @head
    counter = 0
    until position == counter
      temp_node = temp_node.link
      counter += 1
    end
    temp_node.value
  end

  def push(value)#add element at the end of LL
    new_node = Node.new(value)
    #if Linked List is empty @head is New Node
    if @head.nil? 
      @head = new_node 
      @size += 1
      return
    end
    #if we already have assigned head, we traversel until we find link with nil value
    temp_node = @head #start with head and assign temp variable
    until temp_node.link == nil #until we find nil
      temp_node = temp_node.link #use link path
    end
    temp_node.link = new_node 
    @size += 1 
  end

  def unshift(value)#add element at the beginnig of LL
    temp_head = Node.new(value) #first create temp head
    temp_head.link = @head #link temp head with rest of linked list with current head
    @head = temp_head #last reassign current head with new head
    @size += 1 
  end

  def insert_at(value, position)#add element at specific position
    #first check if LL has any value, or inserting is at position 0
    #if condition is met add node at beginning of LL
    return self.unshift(value) if @size == 0 || position == 0
    #second check if LL position we waht to add is greater then size or equal to to size
    #if condition is met add node at end of LL
    return self.push(value) if position >= @size
    #if conditions before are not met, insertion between 2 nodes must be done
    counter = 1
    temp_node = @head
    until position == counter #traverse until counter is beatween nodes we whant insetr
      temp_node = temp_node.link
      counter += 1
    end
    new_node = Node.new(value) #create new node
    new_node.link = temp_node.link #takeover temp_node link to new_node
    temp_node.link = new_node #and then just redirct temp node to new(which have path from temp node)
  end

  def pop()#removes last element
    if @size == 1
      @head = nil
      return
    end

    temp_node = @head
    counter = 1
    until counter == @size - 1
      temp_node = temp_node.link
      counter += 1
    end
    temp_node.link = nil
  end

  def shift()#removes first element
    temp_head = @head.link
    @head = temp_head
  end

  def delete_at(position)
    return nil if @size == 0
    return self.shift() if @size == 1 || position == 0
    return self.pop() if position >= @size

    counter = 1
    temp_node = @head 
    until counter == position
      temp_node = temp_node.link
      counter += 1
    end
    temp_node.link = temp_node.link.link
  end
end

x = LinkedList.new
x.push('Neo')
x.push('Trinity')
x.push('Morphius')
x.unshift('Tank')
x.unshift('Link')
x.to_s
x.delete_at(3)
x.to_s







#print elements
#print in reverse
#return value at index
#insert node at tail+
#insert node at head+
#insert node at spacific position
#delete node at tail
#delete node at head
#delete node at spacific position
#reverse a linked list
#compare two linked lists
#merge 2 sorted linked lists
#get node value
#size
#contains?
#search