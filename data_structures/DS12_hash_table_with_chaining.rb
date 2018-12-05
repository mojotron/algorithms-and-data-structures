class HashTable
  #In this implementation, instead of using "DS1_linked_list.rb" file, will use two helper classes.
  #Node class is used for representing element in the table. Node has 3 containers for saveing
  #key(hash code), value(data to store), link(memory addres for next node in the list).
  class Node
    attr_accessor :key, :value, :link 
    def initialize(key, value)
      @key = key
      @value = value
      @link = nil
    end
  end
  #Linked list class has one container for first node witch is empty on initialtzation. Class have 
  #one method which is string representation of individal list in the table.
  class LinkedList
    attr_accessor :head
    def initialize()
      @head = nil
    end
    
    def list_display()
      container = String.new()
      temp_node = @head
      until temp_node == nil
        container += "#{temp_node.value} -> "
        temp_node = temp_node.link
      end
      container + 'nil'
    end
  end
  #Hash table class is initialize as 11 element array, each element in array is new linked list
  attr_accessor :space_limit, :table, :element_count
  def initialize()
    @space_limit = 11
    @table = Array.new(@space_limit).map {LinkedList.new}
    @element_count = 0
  end

  def table_display()
    @table.each_with_index do |list, index|
      puts "#{index}: #{list.list_display()}"
    end
  end

  def hash_generator(key)
    return nil if key == nil
    sum_of_char = 0
    key.to_s.each_char { |char| sum_of_char += char.ord }
    sum_of_char % @space_limit
  end

  def insert(key, value)
    new_node = Node.new(key, value)
    hash_code = self.hash_generator(key)
    #if head in individual linked list is nil, append new node and exit
    if @table[hash_code].head == nil
      @table[hash_code].head = new_node
      @element_count += 1
      return
    else
      #If head is not nil, traversal the list and check up if key is already used, if it is
      #change current value vith new value
      temp_node = @table[hash_code].head
      until temp_node == nil
        if temp_node.key == key
          return temp_node.value = value
        end
        temp_node = temp_node.link
      end
    end
    #If head is not nil and key is not used append node at the beginning of the individual list
    new_node.link = @table[hash_code].head
    @table[hash_code].head = new_node
    @element_count += 1
    value
  end

  def search(key)
    hash_code = self.hash_generator(key)
    temp_node = @table[hash_code].head
    counter = 0
    until temp_node == nil
      if temp_node.key == key
        puts "Key: #{key}, list-index: #{hash_code}, position: #{counter}, value: #{temp_node.value}"
        return temp_node.value
      end
      counter += 1
      temp_node = temp_node.link
    end
    puts "Key: #{key} not found!"
    nil
  end

  def delete(key)
    hash_code = self.hash_generator(key)

    if @table[hash_code].head == nil
      puts "Key #{key} not found!"
      return nil
    end

    value = nil
    temp_node = @table[hash_code].head
    #if element for delete is first in the list, change head of individual
    #list for next element in the list
    if temp_node.key == key
      value = temp_node.value
      next_node = temp_node.link
      @table[hash_code].head = next_node
      @element_count -= 1
      return value
    end
    #if element for delete is not first element traversal the list
    until temp_node.link == nil
      next_node = temp_node.link.link
      if temp_node.link.key == key
        value = temp_node.link.value
        temp_node.link = next_node
        @element_count -= 1
        return value
      end
      temp_node = temp_node.link
    end
  end

  def table_size()
    @element_count
  end

  def is_empty?()
    (@element_count == 0) ? true : false
  end
end

x = HashTable.new()
x.insert('Howkeye', "Clint Barton")
x.insert('Thor', "Thor Odinson")
x.insert('Hulk', "Bruce Benner")
x.insert('Capitan America', "Steve Rogers")
x.insert('Iron-man', "Tony Stark")
x.insert('Black Widow', "Natalia Romanova")
x.insert('Spider-man', "Peter Parker")
x.insert('Ant-man', "Scott Lang")
x.insert('Winter Solider', "Bucky Barnes")
x.insert('Black Panter', "T'Challa")
x.insert('Falcon', 'Sam Wilson')
x.insert('Scarlet Witch', 'Wanda Maximoff')

x.insert('Hulk', "BRUCE BANNER")
x.search('Ant-man')
x.search('Winter Solider')
x.search('Falcon')
x.delete('Howkeye')
x.delete('Thor')
x.insert('Vision', "Vision stone + ultron")
x.insert('Vision', "Vision stone + ultron".upcase)


x.table_display()
p x.table_size()
p x.is_empty?()
