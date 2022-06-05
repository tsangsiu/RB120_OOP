=begin

class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

=end

# The above code raises an error because there is no setter method defined for the instance variable @name

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
p bob.name
bob.name = "Bob"
p bob.name
