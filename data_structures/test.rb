class Queue
  attr_accessor :space_limit, :queue, :head, :tail
  def initialize(space_limit = 10)
    @space_limit = space_limit
    @queue = Array.new()
    @head = -1
    @tail = -1
  end

  def is_empty?()
    (@head == -1 && @tail == -1) ? true : false
  end

  def is_full?()
    ((@tail + 1) % space_limit == @head) ? true : false
  end

  def enqueue(value)
    if self.is_full?()
      return puts "Queue is full!"
    elsif self.is_empty?()
      @head = 0
      @tail = 0
    else
      @tail = (@tail + 1) % space_limit
    end
    @queue[@tail] = value
  end

  def dequeue()
    value = nil
    if self.is_empty?()
      puts "Queue is empty!"
    elsif @head == @tail
      value = @queue[@head]
      @head = -1
      @tail = -1
    else
      value = @queue[@head]
      @head = (@head + 1) % space_limit
    end
    value
  end

  def peek()
    return nil if self.is_empty?()
    @queue[@head]
  end

  def queue_size()
    return 0 if self.is_empty?()
    (@head > @tail) ? (space_limit - @head + @tail + 1) : (@tail - @head + 1)
  end

  def display()
    return puts "Queue is empty!" if self.is_empty?()
    container = Array.new()
    2.times do
      @queue.each { |item| container << item}
    end

    print "Out "
    container[@head, self.queue_size()].each { |item| print "<- [#{item}] " }
    puts "<- In"
  end
end

x = Queue.new(5)
x.enqueue('A')
x.enqueue('B')
x.enqueue('C')
x.enqueue('D')
x.enqueue('E')
puts "Peek is #{x.peek()}" 
x.display()
p x.dequeue()
puts "Peek is #{x.peek()}" 
x.display()
p x.dequeue()
puts "Peek is #{x.peek()}" 
x.display()
p x.dequeue()
puts "Peek is #{x.peek()}" 
x.display()
p x.dequeue()
puts "Peek is #{x.peek()}" 
x.display()
p x.dequeue()
puts "Peek is #{x.peek()}" 
x.display()
p x.queue_size()