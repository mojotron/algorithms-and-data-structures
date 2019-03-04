class MaxHeap 
  attr_accessor :heap 
  def initialize()
    @heap = [nil]
  end

  def size()
    @heap.size - 1
  end

  def insert(value)
    @heap << value
    bubble_up(self.size)
  end

  def bubble_up(index)
    while index / 2 > 0
      if @heap[index] >= @heap[index / 2]
        @heap[index], @heap[index / 2] = @heap[index / 2], @heap[index]
      end 
      index /= 2
    end
  end

  def max_value()
    @heap[1]
  end

  def get_max_value()
    largest = @heap[1]
    @heap[1] = @heap.pop()
    heapify_max(1)
    largest
  end

  def heapify_max(index)
    left_child = index * 2
    right_child = index * 2 + 1
    if left_child <= self.size && @heap[left_child] > @heap[index]
      largest = left_child
    else
      largest = index
    end
    if right_child <= self.size && @heap[right_child] > @heap[largest]
      largest = right_child
    end
    if largest != index
      @heap[index], @heap[largest] = @heap[largest],@heap[index]
      heapify_max(largest)
    end
  end

  def build_heap(arr)
    @heap += arr
    i = self.size / 2
    while i > 0
      heapify_max(i)
      i -= 1
    end
    @heap
  end

end

def heap_sort(arr)
  h = MaxHeap.new()
  h.build_heap(arr)
  sort = []
  until h.size == 0
    h.heap[1], h.heap[h.size] = h.heap[h.size], h.heap[1]
    sort << h.heap.pop()
    h.heapify_max(1)
  end
  sort
end

arr = [3,6,9,1,10,7,33,12,42,13,2,15,65,71,16]
x = MaxHeap.new()
x.insert(3)
x.insert(6)
x.insert(9)
x.insert(1)
x.insert(10)
x.insert(7)
p x.heap
y = MaxHeap.new()
y.build_heap(arr)
p y.heap

p heap_sort(arr)
