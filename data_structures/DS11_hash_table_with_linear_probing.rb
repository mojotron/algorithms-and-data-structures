class HashTable

  class Node
    attr_accessor :key, :value
    def initialize(key, value)
      @key = key
      @value = value
    end
  end

  attr_accessor :space_limit, :table, :element_count
  def initialize()
    @space_limit = 11
    @table = Array.new(@space_limit, nil)
    @element_count = 0
  end

  def hash_generator(key)
    return nil if key == nil
    sum_of_char = 0

    key.to_s.each_char do |char|
      sum_of_char += char.ord
    end
    sum_of_char % @space_limit
  end

  def display()
    @table.each_with_index do |node, index|
      puts "#{index}-> #{(node == nil) ? node : node.value}"
    end
  end

  def insert(key, value)
    new_node = Node.new(key, value)
    hash_code = self.hash_generator(key)
    
    if @table[hash_code] == nil
      @table[hash_code] = new_node
      @element_count += 1
      return
    else 
      if @table[hash_code].key == "*deleted-key*"
        @table[hash_code] = new_node
        @element_count += 1
        return
      elsif @table[hash_code].key == key #check if key is olready used, if is change old value with new
        return @table[hash_code].value = value #replace value
      else
        #LINEAR PROBING: search for next empty spot(or used key)
        start_position = hash_code
        while @table[hash_code] != nil && @table[hash_code].key != key &&
          @table[hash_code].key != "*deleted-key*" && (hash_code + 1) % @space_limit != start_position
          hash_code = (hash_code + 1) % @space_limit #circular array iteration
        end
        #loop has reach 1 of 4 stop conditions
        if @table[hash_code] == nil #if slot in the array is empty add new element to thet slot
          @table[hash_code] = new_node
          @element_count += 1
          return 
        elsif @table[hash_code].key == "*deleted-key*" #if slot was deleted and hes dummy node, rewrite it
          @table[hash_code] = new_node
          @element_count += 1
          return
        elsif @table[hash_code].key == key  #if loop has reached element with key already used change old value with new
          return @table[hash_code].value = value
        else #if loop has pass all elements in the array
          puts "Table is full!"
        end
      end
    end
  end

  def search(key)
    hash_code = self.hash_generator(key)
    start_position = hash_code
    while @table[hash_code] != nil && (hash_code + 1) % @space_limit != start_position
      if @table[hash_code].key == key
        puts "Key: #{key}, at index: #{hash_code}, has value: #{@table[hash_code].value}."
        return @table[hash_code].value
      else
        hash_code = (hash_code + 1) % @space_limit
      end
    end
    puts "Key: #{key}, not found!"
    nil
  end

  def delete(key)
    delete_node = Node.new('*deleted-key*', '*deleted-value*')
    hash_code = self.hash_generator(key)
    start_position = hash_code
    while @table[hash_code] != nil && (hash_code + 1) % @space_limit != start_position
      if @table[hash_code].key == key
        value = @table[hash_code].value
        @table[hash_code] = delete_node
        @element_count -= 1
        return value
      end
      hash_code = (hash_code + 1) % @space_limit
    end
  end

  def is_empty?()
    (@element_count == 0) ? true : false
  end

  def is_full?()
    (@element_count == @space_limit) ? true : false
  end

  def table_size()
    @element_count
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
x.insert('Scarlet Witch', ' Wanda Maximoff')

x.insert('Hulk', "BRUCE BANNER")
x.search('Ant-man')
x.search('Winter Solider')
x.search('Falcon')

x.delete('Iron-man')
x.insert('Vision', "Vision stone + ultron")

x.display()
p x.table_size()
p x.is_empty?()
p x.is_full?()
