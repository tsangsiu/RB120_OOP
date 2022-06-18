class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin

# Further Exploration

While `attr_accessor` provides us with both the getter and the setter methods of
the concerned instance variables, `attr_reader` and `attr_writer` provide us
with only the getter and the setter methods respectively.

We use `attr_reader` because we specifically need that. If we use `attr_writer`,
we will only get the setter method. If we use `attr_accessor`, we will have both
the setter and the getter methods. In our code, we do not need the setter method.
Exposing the setter method outside the object would potentially have unexpected
consequence like accentially changing the state of an object.

Instead of `attr_reader`, we can also create getter methods manually. In this
case, that won't change the behavior of the class in anyway. However, in some
situation, writing the getter mehtod manually is prefereable when we wish to
manipulate the values referenced by instance variables. Especially the case when
the data are sensitive data, we would like to mask them before outputting them.

=end
