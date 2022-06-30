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

`@@cats_count` is a class variable that counts the number of `Cat` object
instantiated.

When a new `Cat` object is instantiated, it triggers the method invocation of 
`initialize`. Inside it, the class variable `@@cats_count` is incremented by 1.

To test it, we can do the following:

=end

Cat.new('ringtail')
Cat.new('shorthair')
p Cat.cats_count # => 2
