class DoublyCircularLinkedList
  class Node
    attr_accessor :value, :link_next, :link_prev
    def initialize(value)
      @value = value
      @link_next = nil
      @link_prev = nil
    end
  end

  attr_accessor :head
  def initialize()
    @head = nil
  end

  def list_size()
    counter = 0
    return counter if @head == nil
    temp_node = @head
    loop do
      counter += 1
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    counter
  end

  def push(value)
    new_node = Node.new(value)
    if @head == nil
      @head = new_node
      @head.link_next = @head
      @head.link_prev = @head
    end
    temp_node = @head
    loop do 
      temp_node = temp_node.link_next
      break if temp_node.link_next == @head
    end
    temp_node.link_next = new_node
    new_node.link_prev = temp_node
    new_node.link_next = @head
    @head.link_prev = new_node
  end

  def unshift(value)
    new_head = Node.new(value)
    if @head == nil
      @head = new_head
      @head.link_next = @head
      @head.link_prev = @head
    end
    temp_node = @head
    until temp_node.link_next == @head
      temp_node = temp_node.link_next
    end
    @head.link_prev = new_head
    new_head.link_next = @head
    temp_node.link_next = new_head
    new_head.link_prev = temp_node
    @head = new_head
  end

  def insert_at(value, index)
    list_size = self.list_size()
    return puts "out of range" if index < 0
    return self.unshift(value) if @head == nil || index == 0 
    return self.push(value) if index >= list_size
    temp_node = @head
    counter = 1
    until index == counter
      counter += 1
      temp_node = temp_node.link_next
    end
    new_node = Node.new(value)
    new_node.link_next = temp_node.link_next
    temp_node.link_next.link_prev = new_node
    new_node.link_prev = temp_node
    temp_node.link_next = new_node 
  end

  def pop()
    return nil if @head == nil
    return @head = nil if @head.link_next == @head
    temp_node = @head
    until temp_node.link_next.link_next == @head
      temp_node = temp_node.link_next
    end
    temp_node.link_next = @head
    @head.link_prev = temp_node
  end

  def shift()
    return nil if @head == nil
    return @head = nil if @head.link_next == @head
    temp_node = @head
    until temp_node.link_next == @head
      temp_node = temp_node.link_next
    end
    @head = @head.link_next
    @head.link_prev = temp_node
    temp_node.link_next = @head
  end

  def delete_at(index)
    list_size = self.list_size()
    return puts "out of range" if index < 0 || index >= list_size
    return self.shift() if @head.link_next == @head || index == 0
    return self.pop() if (list_size - 1) == index
    temp_node = @head
    counter = 1
    until counter == index
      temp_node = temp_node.link_next
    end
    store_node = temp_node.link_next.link_next
    store_node.link_prev = temp_node
    temp_node.link_next = store_node
  end

  def search(value)
    return nil if @head == nil
    temp_node = @head
    loop do
      return temp_node.value if temp_node.value == value
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    nil
  end

  def contains?(value)
    return false if @head == nil
    temp_node = @head
    loop do
      return true if temp_node.value == value
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    false
  end

  def value_at(index)
    list_size = self.list_size()
    return puts "out of range" if index < 0 || index >= list_size
    counter = 0
    temp_node = @head
    until counter == index
      counter += 1
      temp_node = temp_node.link_next
    end
    temp_node.value
  end

  def index_of(value)
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

  def to_s()
    return puts "list is empty" if @head == nil
    string = "[tail(#{@head.link_prev.value})] <-> "
    temp_node = @head
    loop do
      string += "#{temp_node.value} <-> "
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    puts string + "[head(#{temp_node.value})]"
  end

  def print_from_head()
    return puts "list is empty" if @head == nil
    temp_node = @head
    loop do
      print "#{temp_node.value} "
      temp_node = temp_node.link_next
      break if temp_node == @head
    end
    puts
  end

  def print_from_tail()
    return puts "list is empty" if @head == nil
    temp_node = @head
    loop do
      temp_node = temp_node.link_prev
      print "#{temp_node.value} "
      break if temp_node == @head
    end
    puts
  end

  def print_recursive(start = @head, current = start)
    return puts "list is empty" if start == nil 
    print "#{current.value} "
    current = current.link_next
    if start != current
      print_recursive(start, current)
    else
      puts
    end
  end

  def print_recursive_reverse(start = @head, current = start)
    return puts "list is empty" if start == nil
    current = current.link_prev
    print "#{current.value} "
    if start != current
      print_recursive_reverse(start, current)
    else
      puts
    end
  end

  def reverse_list()
    return @head if @head == nil || @head.link_next == @head
    temp_node = @head
    prev_node = nil
    loop do
      next_node = temp_node.link_next
      prev_node = temp_node.link_prev
      temp_node.link_prev = temp_node.link_next
      temp_node.link_next = prev_node
      temp_node = next_node
      break if temp_node == @head
    end
    @head = prev_node.link_prev
  end

  def reverse_list_recursive(start = @head, current = start)
    store_node = current.link_next
    current.link_next = current.link_prev
    current.link_prev = store_node
    current = current.link_prev
    if start == current
      return @head = current.link_next
    else
      reverse_list_recursive(start, current)
    end
  end

  def insertion_sort()
    return @head if @head == nil || @head.link_next == @head
    outher_node = @head.link_next
    loop do
      inner_node = outher_node
      loop do
        if inner_node.value <= inner_node.link_prev.value
          store_value = inner_node.value
          inner_node.value = inner_node.link_prev.value
          inner_node.link_prev.value = store_value
        end
        inner_node = inner_node.link_prev
        break if inner_node == @head
      end
      outher_node = outher_node.link_next
      break if outher_node == @head
    end
  end

  def divide_list(list = @head)
    if list == nil || list.link_next == list
      left = list
      right = nil
      return [left, right]
    end
    slow_pointer = list
    fast_pointer = list
    while fast_pointer.link_next != list && fast_pointer.link_next.link_next != list
      fast_pointer = fast_pointer.link_next.link_next
      slow_pointer = slow_pointer.link_next
    end
    temp_node = list
    until temp_node.link_next == list
      temp_node = temp_node.link_next
    end
  
    left = list
    right = slow_pointer.link_next
    left.link_prev = slow_pointer
    slow_pointer.link_next = left
    right.link_prev = temp_node
    temp_node.link_next = right

    [left, right]
  end

  def merge_sorted_lists(left, right)
    new_node = Node.new(0)
    result_node = new_node
    left_node = left
    right_node = right
    loop do
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
    loop do
      result_node.link_next = left_node
      left_node.link_prev = result_node
      left_node = left_node.link_next
      result_node = result_node.link_next
      break if left_node == left
    end
    loop do 
      result_node.link_next = right_node
      right_node.link_prev = result_node
      right_node = right_node.link_next
      result_node = result_node.link_next
      break if right_node == right
    end
    result_node.link_next = new_node.link_next
    new_node.link_next.link_prev = result_node
    new_node.link_next
  end

  def merge_sort(list = @head)
    return nil if list == nil
    if list.link_next == list
      return list
    else
      left_part, right_part = divide_list(list)
      left = merge_sort(left_part)
      right = merge_sort(right_part)
      @head = merge_sorted_lists(left, right)
      
    end
  end

  def delete_dupicate_sorted()
    return @head if @head == nil || @head.link_next == @head
    temp_node = @head
    loop do
      break if temp_node.link_next == @head
      if temp_node.value == temp_node.link_next.value
        temp_node.link_next = temp_node.link_next.link_next
      else
        temp_node = temp_node.link_next
        break if temp_node == @head
      end
    end
  end

  def delete_dupicate_unsorted()
    return @head if @head == nil || @head.link_next == @head
    temp_node = @head
    loop do
      current_node = temp_node
      loop do
        break if current_node.link_next == @head
        if temp_node == current_node
          current_node.link_next = current_node.link_next.link_next
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

list = DoublyCircularLinkedList.new()
list.push('E')
list.push('C')
list.push('F')
list.push('D')
list.push('A')
list.push('B')

list.to_s()
list.reverse_list()
list.to_s()