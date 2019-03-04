class BinaryHeap #minimum heap
  #parent => i / 2
  #left_child => i * 2
  #right_child => i * 2 + 1
  attr_accessor :heap
  def initialize()
    @heap = [nil] #heap starts from index 1, so occupy index zero
  end

  def size()
    @heap.size - 1
  end

  def insert(value)
    @heap << value
    bubble_up(self.size)
  end

  def bubble_up(index) #after inserting element to the last spot(leaf), check are heap condition are met
    while index / 2 > 0 #while current index is not root
      if @heap[index] <= @heap[index / 2] #if current node is smaller then parent node, do swap
        @heap[index], @heap[index / 2] = @heap[index / 2], @heap[index]
      end
      index /= 2
    end
  end

  def min_value()
    @heap[1]
  end

  def get_min_value()
    smallest = @heap[1]
    @heap[1] = @heap.pop()
    heapify_min(1)
    smallest
  end

  def heapify_min(index) #heapify_min
    left_child = index * 2
    right_child = index * 2 + 1
    if left_child <= self.size && @heap[left_child] < @heap[index]
      smallest = left_child
    else
      smallest = index
    end
    if right_child <= self.size && @heap[right_child] < @heap[smallest]
      smallest = right_child
    end
    if smallest != index
      @heap[index], @heap[smallest] = @heap[smallest], @heap[index]
      heapify_min(smallest)
    end
  end

  def build_heap(arr)
    @heap += arr
    i = self.size / 2
    while i > 0
      heapify_min(i)
      i -= 1
    end
    @heap
  end
end

def heap_sort(arr)
  h = BinaryHeap.new()
  h.build_heap(arr)
  sort = []
  until h.size == 0
    h.heap[1], h.heap[h.size] = h.heap[h.size], h.heap[1]
    sort << h.heap.pop()
    h.heapify_min(1)
  end
  sort
end



arr = [14,33,60,9,5,7,8,2,4,3,1,6,12,20]
x = BinaryHeap.new()
arr.each do |ele|
  x.insert(ele)
end
p x.heap
y = BinaryHeap.new()
y.build_heap(arr)
p y.heap
p heap_sort(arr)
