# My original solution, which happens to be the solution for Further Exploration

# class CircularQueue
#   def initialize(size)
#     @circular_queue = []
#     @size = size
#   end

#   def dequeue
#     return nil if @circular_queue.empty?
#     @circular_queue.shift
#   end

#   def enqueue(element)
#     dequeue if @circular_queue.size >= @size
#     @circular_queue << element
#   end
# end

class CircularQueue
  def initialize(size)
    @queue = Array.new(size)
    @size = size
    @start = 0
    @end = 0
  end

  def dequeue
    return nil if empty?
    element_dequeued = @queue[@start]
    @queue[@start] = nil
    @start = next_index(@start)
    element_dequeued
  end

  def enqueue(element)
    if empty?
      @queue[@start] = element
    else
      @end = next_index(@end)
      @queue[@end] = element
      if @end == @start && @queue[next_index(@start)] != nil
        @start = next_index(@start)
      end
    end
  end

  def empty?
    @queue.all?(&:nil?)
  end

  def to_s
    @queue.to_s
  end

  private

  def next_index(index)
    (index + 1) % @size
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
