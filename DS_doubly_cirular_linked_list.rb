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
    temp_node = @head
    counter = 0
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

  def print_recursive()
  end

  def print_recursive_reverse()
  end

  def reverse_list()
  end

  def reverse_list_recursive()
  end

  def insertion_sort()
  end

  def merge_sort()
  end

  def divide_list()
  end

  def merge_sorted_lists()
  end

  def delete_dupicate_sorted()
  end

  def delete_dupicate_unsorted()
  end

end

list = DoublyCircularLinkedList.new()
list.push('C')
list.unshift('A')
list.insert_at('B',1)
list.push('D')
list.push('E')
list.push('F')
list.to_s()
list.print_from_head()
list.print_from_tail()
