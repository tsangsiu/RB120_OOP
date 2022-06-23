class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, fur_color)
    super(name, age)
    @fur_color = fur_color
  end
  
  def to_s
    "My cat #{@name} is #{@age} years old and has #{@fur_color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

=begin

# Further Exploration

We would be able to omit the `initialize` method in that case because when Ruby
looks for the `initialize` method in the class `Cat` and it doesn't have it, it
will go to `Cat`'s superclass to look for that method.

It would not be a good idea to modify `Pet` in this way because not all pets
have fur. Also, when we add an extra parameter to `initialize` in the `Pet`
class, we have to check all its subclasses, because they may depend on it due to
inheritance.

=end
