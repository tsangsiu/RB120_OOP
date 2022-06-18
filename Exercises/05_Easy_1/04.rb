class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin

# Further Exploration

What do you think of this way of creating and initializing Book objects? (The 
two steps are separate.) Would it be better to create and initialize at the same
time like in the previous exercise? What potential problems, if any, are 
introduced by separating the steps?

It really depends on your intention.

When an object's state is not supposed to be altered after its instantiation,
such way of object instantiation would be problematic by exposing setter
interface.

=end
