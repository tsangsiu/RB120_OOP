# Solution 1: @st and @en are the indices of the first and last objects
class CircularQueue
  def initialize(size)
    @queue = Array.new(size, nil)
    @st = 0; @en = 0
  end

  def enqueue(element)
    @en = next_idx(@en) unless @queue[@en].nil?
    @st = next_idx(@st) if @st == @en && !@queue[@st].nil?
    @queue[@en] = element    
    @queue
  end

  def dequeue
    element_dequeued = @queue[@st]
    @queue[@st] = nil
    @st = next_idx(@st) unless element_dequeued.nil? || @queue.all?(&:nil?)
    element_dequeued
  end

  def queue
    @queue.clone
  end

  private
  
  def next_idx(idx)
    (idx + 1) % @queue.size
  end
end

# Solution 2: @old, @next are the indices of the oldest object and the position of the next object to be added
class CircularQueue
  attr_reader :old, :next
  
  def initialize(size)
    @queue = Array.new(size, nil)
    @old = 0; @next = 0
  end
  
  def dequeue
    element_dequeued = @queue[@old]
    @queue[@old] = nil
    @old = next_idx(@old) unless element_dequeued.nil?
    element_dequeued
  end
  
  def enqueue(element)
    @old = next_idx(@old) unless @queue[@next].nil?
    @queue[@next] = element
    @next = next_idx(@next)
    @queue
  end
  
  def queue
    @queue.clone
  end

  private
  
  def next_idx(idx)
    (idx + 1) % @queue.size
  end
end

# Further Exploration
# (my original, easier-to-implement solution)

class CircularQueue
  def initialize(size)
    @size = size
    @queue = []
  end

  def enqueue(element)
    @queue.shift if @queue.size >= @size
    @queue << element
    @queue
  end
  
  def dequeue
    @queue.shift
  end
  
  def queue
    @queue.clone
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
