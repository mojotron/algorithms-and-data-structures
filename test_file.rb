class CircularLinkedList
  class Node
    attr_accessor :value, :link
    def initialize(value)
      @value = value
      @link = nil
    end
  end

  attr_accessor :head
  def initialize()
    @head = nil
  end

  def list_size()
    return 0 if @head == nil
    counter = 0
    temp_node = @head
    loop do 
      counter += 1
      temp_node = temp_node.link
      break if temp_node == @head
    end
    counter
  end

  def push(value)
    new_node = Node.new(value)
    if @head == nil
      @head = new_node
      @head.link = @head
      return
    end
    temp_node = @head
    until temp_node.link == @head
      temp_node = temp_node.link
    end
    new_node.link = @head
    temp_node.link = new_node
  end

  def unshift(value)
    new_head = Node.new(value)
    if @head == nil
      @head = new_head
      @head.link = @head
      return
    end
    temp_node = @head
    until temp_node.link == @head
      temp_node = temp_node.link
    end
    
    new_head.link = @head
    @head = new_head
    temp_node.link = @head
  end

  def insert_at(value, index)
    list_size = self.list_size()
    return puts 'out of range' if index > list_size || index < 0
    return self.unshift(value) if list_size == 0 || index == 0
    return self.push(value) if index == list_size
    counter = 1
    temp_node = @head
    until counter == index
      temp_node = temp_node.link
      counter += 1
    end
    new_node = Node.new(value)
    new_node.link = temp_node.link
    temp_node.link = new_node
  end
  
  def pop()
    return nil if @head == nil
    return @head = nil if self.list_size() == 1
    temp_node = @head
    until temp_node.link.link == @head
      temp_node = temp_node.link
    end
    temp_node.link = @head
  end

  def shift()
    return nil if @head == nil
    return @head = nil if self.list_size() == 1
    temp_node = @head
    until temp_node.link == @head
      temp_node = temp_node.link
    end
    @head = @head.link
    temp_node.link = @head
  end

  def delete_at(index)
    list_size = self.list_size()
    return puts 'out of range' if index >= list_size || index < 0
    return self.shift() if list_size == 1 || index == 0
    return self.pop() if (list_size - 1) == index
    temp_node = @head
    counter = 1
    until counter == index
      temp_node = temp_node.link
      counter += 1
    end
    temp_node.link = temp_node.link.link
  end

  def to_s()
    return puts "list is empty" if @head == nil
    string = ''
    temp_node = @head
    loop do 
      string += "#{temp_node.value} -> "
      temp_node = temp_node.link
      break if temp_node == @head
    end
    puts string + "head(#{self.head.value})"
  end

  def print_recursiv(start = @head, current = start)
    #You will need to pass in two parameters, the current element and the starting element.
    #For your first call, these will be the same. Once you've printed the current element,
    #recursively call on the next element in the list. Only do the recursive call if the 
    #next element != the starting element.
    print "#{current.value} -> "
    current = current.link
    if current != start
      print_recursiv(start, current)
    end
    if current == start
      puts 'head'
    end
  end

  def print_reverse_recursive(start = 0, current = @head)
    if current == start
      return
    end
    print_reverse_recursive(start = @head, current.link)
    print "#{current.value} -> "
  end

  def search(value)
    return nil if @head == nil
    temp_node = @head
    loop do
      return temp_node.value if temp_node.value == value
      temp_node = temp_node.link
      break if temp_node == @head
    end
    nil
  end

  def contains?(value)
    return false if @head == nil
    temp_node = @head
    loop do
      return true if temp_node.value == value
      temp_node = temp_node.link
      break if temp_node == @head
    end
    false
  end

  def value_at(index)
    list_size = self.list_size()
    return nil if index < 0 || index >= list_size
    temp_node = @head
    counter = 0
    until counter == index
      temp_node = temp_node.link
      counter += 1
    end
    temp_node.value
  end

  def index_of(value)
    return nil if @head == nil
    temp_node = @head
    counter = 0
    loop do
      return counter if temp_node.value == value
      temp_node = temp_node.link
      counter += 1
      break if temp_node == @head
    end
    nil
  end

  def reverse_list()
    return @head if @head == nil || @head.link == @head
    temp_node = @head
    prev_node = @head
    loop do
      next_node = temp_node.link
      temp_node.link = prev_node
      prev_node = temp_node
      temp_node = next_node
      break if temp_node == @head
    end
    @head.link = prev_node
    @head = prev_node
  end

  def bubble_sort()
    return @head if @head == nil || @head.link == @head
    outer_node = @head
    loop do
      inner_node = outer_node
      loop do
        if outer_node.value > inner_node.value
          store_value = inner_node.value
          inner_node.value = outer_node.value
          outer_node.value = store_value
        end
        inner_node = inner_node.link
        break if inner_node == @head
      end
      outer_node = outer_node.link
      break if outer_node == @head
    end
  end

  def merge_sort(list = @head)
    if list.link == list
      return
    end
    left_part, right_part = divide_list(list)
    left = merge_sort(left_part)
    right = merge_sort(right_part)
    @head = merge_sorted_lists(left, right)
  end

  def divide_list(list = @head)
    if list == nil || list.link == @head
      left = list
      right = nil
      return [left, right]
    end
    slow_pointer = list
    fast_pointer = list
    loop do
      fast_pointer = fast_pointer.link
      if fast_pointer != list
        fast_pointer = fast_pointer.link
        slow_pointer = slow_pointer.link
      end
      break if fast_pointer == list
    end

    temp_node = list
    until temp_node.link == list
      temp_node = temp_node.link
    end
    
    left = list
    right = slow_pointer.link
    slow_pointer.link = left#if we want 2 circualr lists then = left
    temp_node.link = right #and = right
    #we are returning non circular list for faster merging
    [left, right]
  end

  def merge_sorted_lists(left, right)
    new_node = Node.new(0)
    result_node = new_node
    while left.link != left && right.link != right
      if left.value <= right.value
        result_node.link = left
        left = left.link
      else
        result_node.link = right
        right = right.link
      end
      result_node = result_node.link
    end
    result_node.link = (left == nil) ? right : left

    temp_node = new_node
    until temp_node.link == nil
      temp_node = temp_node.link
    end
    temp_node.link = new_node.link
    new_node.link
  end

  def delete_dupicate_sorted()
  end

  def delete_dupicate_unsorted()
  end
end

list = CircularLinkedList.new
list.push('A')
list.push('B')
list.push('C')
list.unshift('D')
list.unshift('E')
list.to_s()
list.bubble_sort()
list.to_s()
l, r = list.divide_list()
x = list.merge_sorted_lists(l, r)
p x
#list.print_recursiv()
#list.print_reverse_recursive()
#p list.list_size()