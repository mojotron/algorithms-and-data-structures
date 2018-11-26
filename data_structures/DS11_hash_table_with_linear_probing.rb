class HashTable
  class Node
    attr_accessor :key, :value 
    def initialize(key, value)
      @key = key
      @value = value
    end

    def to_s()
     @value
    end
  end

  attr_accessor :space_limit, :table, :head, :tail
  def initialize(space_limit = 10)
    @space_limit = space_limit
    @table = Array.new(space_limit)
  end

  def hashing(key)
    if key.class == String
      key = key.sum
    else
      puts "Incorrect input, please enter string!"
      return
    end
    key = key % @space_limit
  end

  def linear_probing(hash_code)
    i = 0
    while i < @space_limit
      hash_code = (hash_code + 1) % @space_limit
      if @table[hash_code] == nil
        return hash_code
      end
      i += 1
    end
    nil
  end

  def insert(key, value)
    new_node = Node.new(key, value)
    hash_code = hashing(key)
    puts "#{key} has hash code: #{hash_code}"
    if @table[hash_code] == nil
      @table[hash_code] = new_node
    else
      x = linear_probing(hash_code)
      if x != nil
        @table[x] = new_node
      else
        puts "table is full"
        return
      end
    end
  end

  def delete(key)
    hash_code = hashing(key)
    x = hash_code
    while true
      if @table[hash_code].key == key
        return @table[hash_code] = nil
      end
      hash_code = (hash_code + 1) % @space_limit
      break if x == hash_code
    end
    puts "Element is not in the table"
  end

  def search(key)
    hash_code = hashing(key)
    x = hash_code
    while true
      if @table[hash_code].key == key
        return @table[hash_code].value
      end
      hash_code = (hash_code + 1) % @space_limit
      break if x == hash_code
    end
    puts "Element is not in the table"
  end

  def display()
    @table.each_with_index { |element, index| puts "#{index}: #{element.to_s()}"}
  end

end

x = HashTable.new()
x.insert('Howkeye', ["Clint Barton", "Shield agent. Speciality: bow and arrow, sniper."])
x.insert('Thor', ["Thor Odinson", "God of tunder, great hair."])
x.insert('Hulk', ["Bruce Benner", "Transformation is green moster. Smashing time!"])
x.insert('Capitan America', ["Steve Rogers", "First test subject of super solider serum."])
x.insert('Iron-man', ["Tony Stark", "Armored and weponized suite."])
x.insert('Black Widow', ["Natalia Romanova", "Agent of shield. Speciality: super spy."])
x.insert('Spider-man', ["Peter Parker", "Bitten by radioactiv spider. Super strength and seanse."])
x.insert('Ant-man', ["Scott Lang", "Body size adaptation."])
x.insert('Winter Solider', ["Bucky Barnes", "Vibranium arm, guns and knifes combantant."])
x.insert('Black Panter', ["T'Challa", "Prince of Wakanda"])
#x.insert('A', ["A A A A"])
x.display()
p x.delete('Spider-mdan')
x.display()