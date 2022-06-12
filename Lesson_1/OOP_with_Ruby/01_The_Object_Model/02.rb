=begin

A module is a collection of behaviors that can be used in different classes
through mixins.

[Purpose] They allows us to group reusable code into one place. They can also be
used as a namespace.

Mixing in a module is a way to achieve polymorphism. This makes code reusable,
and different classes can have its own refined methods of the same name.

To mix in a module in our defined class, we invoke the method `include` with the
module name as an argument.

=end

module Movable
  def move
    puts "start moving..."
  end
end

class Dog
  include Movable
end

my_dog = Dog.new
my_dog.move # => start moving...
