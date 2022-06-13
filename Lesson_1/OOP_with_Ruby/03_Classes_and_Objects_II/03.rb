=begin

We get the error because the setter method for the instance variable `@name` is
not defined. We can get that back on top of the getter method using the method
`attr_accessor`:

=end

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
p bob.name
