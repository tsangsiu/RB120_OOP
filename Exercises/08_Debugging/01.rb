class Library
  attr_accessor :address, :phone, :books

  def initialize(address, phone)
    @address = address
    @phone = phone
    @books = []
  end

  def check_in(book)
    books.push(book)
  end
end

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def display_data
    puts "---------------"
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "ISBN: #{isbn}"
    puts "---------------"
  end
end

community_library = Library.new('123 Main St.', '555-232-5652')
learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

community_library.check_in(learn_to_program)
community_library.check_in(little_women)
community_library.check_in(wrinkle_in_time)

# community_library.books.display_data

=begin
On line 42, when we invoke the getter method of `@books` on the `Library` object
referenced by `community_library`, it returns an array of `Book` objects. As the 
`display_data` method is not defined in the `Array` class, but the `Book` class,
line 42 raises `NoMethodError`.

To fix the code, we should iterate through the array and invoke the `display_data`
method on each `Book` object like so:

````ruby
community_library.books.each(&:display_data)
````
=end

community_library.books.each(&:display_data)
