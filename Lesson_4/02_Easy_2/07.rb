class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

=begin

The class variable `@@cats_count` counts the number of instances instantiated 
from the `Cat` class.

Every time a new object is instantiated from the `Cat` class, the `initialize`
method is called, and hence `@@cats_count` is incremented by 1.

=end

my_cat_1 = Cat.new('Birman')
my_cat_2 = Cat.new('Bombay')
p Cat.cats_count # => 2
