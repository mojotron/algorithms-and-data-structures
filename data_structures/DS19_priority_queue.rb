class PriorityQueue
  attr_accessor :queue
  def initialize()
    @queue = Hash.new()
  end

  def is_empty?
    @queue.empty?
  end

  def insert(value, priority)
    @queue[value] = priority
    sort_priority()
  end

  def get_highest_priority()
    @queue.shift()
  end

  def sort_priority()
    @queue = @queue.sort_by { |k,v| v }.to_h
  end
end

x = PriorityQueue.new()
x.insert('A',3)
x.insert('C',2)
x.insert('B',5)
x.insert('E',1)
x.insert('D',7)
p x.queue
p x.get_highest_priority()
p x.queue

