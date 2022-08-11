# Practice Problems

## 1

What is the output and why? What does this demonstrate about instance variables that differentiates them from local variables?

````ruby
class Person            # 1
  attr_reader :name     # 2
                        # 3
  def set_name          # 4
    @name = 'Bob'       # 5
  end                   # 6
end                     # 7
                        # 8
bob = Person.new        # 9
p bob.name              # 10
````

The line 10 outputs `nil` to the console.

On line 9, a new `Person` object is instantiated and assigned to the local variable `bob`.

On line 10, the getter method of the instance variable `@name` is invoked on the `Person` object just created. As `@name` is not initialized until `#set_name` is invoked, line 10 outputs `nil` to the console.

This demonstrates that **Ruby treats uninitialized instance variables as if they point to `nil`. Unlike local variables, they throw a `NameError` when an uninitialized local variable is called.**

## 2

What is the output and why? What does this demonstrate about instance variables?

````ruby
module Swimmable                 # 1
  def enable_swimming            # 2
    @can_swim = true             # 3
  end                            # 4
end                              # 5
                                 # 6
class Dog                        # 7
  include Swimmable              # 8
                                 # 9
  def swim                       # 10
    "swimming!" if @can_swim     # 11
  end                            # 12
end                              # 13
                                 # 14
teddy = Dog.new                  # 15
p teddy.swim                     # 16
````

The line 16 outputs `nil` to the console.

On line 15, a new `Dog` object is instantiated and assigned to the local variable `teddy`. The instance method `swim` is then called on the object. As the instance variable `@can_swim` is not initialized until `#enable_swimming` is invoked, Ruby treats it as if it points to `nil`, which is falsy. Hence `teddy.swim` returns `nil` and line 16 outputs `nil` to the console.

This demonstrates that **Ruby treats uninitialized instance variables as if they point to `nil`. Unlike local variables, they throw a `NameError` when an uninitialized one is called.**

## 3

What is the output and why? What does it demonstrate about constant scope? What does `self` refer to in each of the three methods below?

````ruby
module Describable                                      # 1
  def describe_shape                                    # 2
    "I am a #{self.class} and have #{SIDES} sides."     # 3
  end                                                   # 4
end                                                     # 5
                                                        # 6
class Shape                                             # 7
  include Describable                                   # 8
                                                        # 9
  def self.sides                                        # 10
    self::SIDES                                         # 11
  end                                                   # 12
                                                        # 13
  def sides                                             # 14
    self.class::SIDES                                   # 15
  end                                                   # 16
end                                                     # 17
                                                        # 18
class Quadrilateral < Shape                             # 19
  SIDES = 4                                             # 20
end                                                     # 21
                                                        # 22
class Square < Quadrilateral; end                       # 23
                                                        # 24
p Square.sides                                          # 25
p Square.new.sides                                      # 26
p Square.new.describe_shape                             # 27
````

The above code outputs the following to the console:

````text
4
4
throws a NameError
````

The above code demonstrates that constants have a lexical scope. Ruby tries to resolve a constant by searching the enclosing class or module (i.e., lexical scope) of the constant reference, then by inheritance of the encolsing class/module, and finally the top level.

Consider the constant reference `SIDES` on line 3, there is no constant definition of `SIDES` in the enclosing module `Describable`, so Ruby will then look for the constant at the top level (as there is no inheritance involved). As the constant is not found either at the top level, Ruby throws a `NameError`.

Consider the method calls on lines 25 and 26, both instruct Ruby to look for the constant in the `Square` class. As `Square` is a subclass of `Quadrilateral` where the constant `SIDES` is defined. Both lines 25 and 26 output `4` to the console.

On lines 3 and 15, both `self` refer to the calling object of the method. While on 11, the `self` refers to the class.

## 4

What is the output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?

````ruby
class AnimalClass                         # 1
  attr_accessor :name, :animals           # 2
                                          # 3
  def initialize(name)                    # 4
    @name = name                          # 5
    @animals = []                         # 6
  end                                     # 7
                                          # 8
  def <<(animal)                          # 9
    animals << animal                     # 10
  end                                     # 11
                                          # 12
  def +(other_class)                      # 13
    animals + other_class.animals         # 14
  end                                     # 15
end                                       # 16
                                          # 17
class Animal                              # 18
  attr_reader :name                       # 19
                                          # 20
  def initialize(name)                    # 21
    @name = name                          # 22
  end                                     # 23
end                                       # 24
                                          # 25
mammals = AnimalClass.new('Mammals')      # 26
mammals << Animal.new('Human')            # 27
mammals << Animal.new('Dog')              # 28
mammals << Animal.new('Cat')              # 29
                                          # 30
birds = AnimalClass.new('Birds')          # 31
birds << Animal.new('Eagle')              # 32
birds << Animal.new('Blue Jay')           # 33
birds << Animal.new('Penguin')            # 34
                                          # 35
some_animal_classes = mammals + birds     # 36
                                          # 37
p some_animal_classes                     # 38
````

The line 38 will outputs an array of `Animal` objects of size 6. The `Animal` objects have the `@name` attributes: `'Human'`, `'Dog'`, `'Cat'`, `'Eagle'`, `'Blue Jay'` and `'Penguin'` (in the same order).

That is not what we would expect when using `AnimalClass#+`. It is because when we use the `+` method, we would expect it to return an object of the same type as the calling object and the argument, just like the built-in Ruby set-up. In the above code, the calling object (the object that `mammals` refers to) and the object that `birds` refers to are both `AnimalClass` objects, but the `AnimalClass#+` method returns an `Array` object.

To be more in line with what we'd expect, we could adjust the implementation of `AnimalClass#+` as follows:

````ruby
def +(other_class)
  result_obj = AnimalClass.new('Result')
  result_obj.animals = self.animals + other_class.animals
  result_obj
end
````

## 5

We expect the code below to output `"Spartacus weighs 45 lbs and is 24 inches tall."` Why does our `change_info` method not work as expected?

````ruby
class GoodDog                                                # 1
  attr_accessor :name, :height, :weight                      # 2
                                                             # 3
  def initialize(n, h, w)                                    # 4
    @name = n                                                # 5
    @height = h                                              # 6
    @weight = w                                              # 7
  end                                                        # 8
                                                             # 9
  def change_info(n, h, w)                                   # 10
    name = n                                                 # 11
    height = h                                               # 12
    weight = w                                               # 13
  end                                                        # 14
                                                             # 15
  def info                                                   # 16
    "#{name} weighs #{weight} and is #{height} tall."        # 17
  end                                                        # 18
end                                                          # 19
                                                             # 20
sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs')     # 21
sparky.change_info('Spartacus', '24 inches', '45 lbs')       # 22
puts sparky.info                                             # 23
# => Spartacus weighs 10 lbs and is 12 inches tall.
````

The intention of the lines of code on lines 11 to 13 is to reassign the data referenced by the instance variables `@name`, `@height` and `@weight` by using their respective setter methods. However, without the prefix `self.`, Ruby will regard it as local variable initialization. Therefore the data referenced by those instance variables are unaltered.

To reassign the data referenced by those instance variables, we should rewrite the `change_info` method as follow:

````ruby
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
````

## 6

In the code below, we hope to output `'BOB'` on line 16. Instead, it raises an error. Why? How could we adjust this code to output `'BOB'`?

````ruby
class Person                # 1
  attr_accessor :name       # 2
                            # 3
  def initialize(name)      # 4
    @name = name            # 5
  end                       # 6
                            # 7
  def change_name           # 8
    name = name.upcase      # 9
  end                       # 10
end                         # 11
                            # 12
bob = Person.new('Bob')     # 13
p bob.name                  # 14
bob.change_name             # 15
p bob.name                  # 16
````

On line 13, a `Person` object with the attribute `@name` references `'Bob'` is instantiated. The new `Person` object is then assigned to the local variable `bob`.

On line 15, the `change_name` method is invoked on the `Person` object that `bob` references. The intention of the method is to alter the value that `@name` references to upper case. However, without the `self.` prefix, Ruby will regard `name` as a local variable instead of the setter for `@name`. Therefore, `@name` is remain unaltered.

To adjust the code to output `'BOB'`, we should implement the `change_name` method as follows:

````ruby
def change_name
  self.name = name.upcase
end
````

## 7

What does the code below output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?

````ruby
class Vehicle                  # 1
  @@wheels = 4                 # 2
                               # 3
  def self.wheels              # 4
    @@wheels                   # 5
  end                          # 6
end                            # 7
                               # 8
p Vehicle.wheels               # 9
                               # 10
class Motorcycle < Vehicle     # 11
  @@wheels = 2                 # 12
end                            # 13
                               # 14
p Motorcycle.wheels            # 15
p Vehicle.wheels               # 16
                               # 17
class Car < Vehicle; end       # 18
                               # 19
p Vehicle.wheels               # 20
p Motorcycle.wheels            # 21
p Car.wheels                   # 22
````

The above code will output:

````text
4
2
2
2
2
2
````

On lines 1 to 7, they define a class `Vehicle` with a class variable `@@wheels` initialized to the value `4` and a class method `Vehicle::wheels` which returns the class variable `@@wheels`.

Therefore, when the class method `::wheels` is called on the class `Vehicle`, it returns `4` and hence the output.

On lines 11 to 13, the class `Motorcycle` is defined to be inherited from the `Vehicle` class. The class `Motorcycle` also inherits the class variable `@@wheels`, and both the `Vehicle` and `Motorcycle` classes share the same copy of the class variable `@@wheels`. On line 12, `@@wheels` is re-assigned to the value `2`.

Therefore, when we call the class method `::wheels` on both the `Vehicle` and `Motorcycle` classes, they both return `2`.

On line 18, the class `Car` is defined to be inherited from the `Vehicle` class, and thus the class `Car` has access to the class variable `@@wheels`. At this point, the value referenced by `@@wheels` is `2`. Therefore, lines 20 to 22 output `2` to the console.

If a superclass has a class variable defined, all its subclasses share the same copy of that class variable. Therefore, when we alter the value it references in one of the subclasses, the change is reflected in all classes that have access to that class variable. Therefore we should avoid using class variables when working with inheritance.

## 8

What is the output and why? What does this demonstrate about `super`?

````ruby
class Animal                     # 1
  attr_accessor :name            # 2
                                 # 3
  def initialize(name)           # 4
    @name = name                 # 5
  end                            # 6
end                              # 7
                                 # 8
class GoodDog < Animal           # 9
  def initialize(color)          # 10
    super                        # 11
    @color = color               # 12
  end                            # 13
end                              # 14
                                 # 15
bruno = GoodDog.new("brown")     # 16     
p bruno                          # 17
````

The above code will output the information about the `GoodDog` object that `bruno` references, which includes the encoding of the object ID and the attributes of the `GoodDog` object. The attributes include two instance variables: `@name` and `@color`, where both reference the string `"brown"`.

On line 16, a new `GoodDog` is instantiated with an argument `"brown"` and assigned to the local variable `bruno`.

Upon instantiation, the method `GoodDog#initialize` is invoked with an argument `"brown"`. The `super` keyword inside the method invokes the method of the same name up in the method lookup path, which is `Animal#initialize`, and passes all arguments to it. Therefore, the instance variable `@name` is assigned to the string `"brown"`. Back to the method `GoodDog#initialize`, the instance variable `@color` is assigned to the string `"brown"`.

Hence the output follows.

## 9

What is the output and why? What does this demonstrate about `super`?

````ruby
class Animal                 # 1
  def initialize             # 2
  end                        # 3
end                          # 4
                             # 5
class Bear < Animal          # 6
  def initialize(color)      # 7
    super                    # 8
    @color = color           # 9
  end                        # 10
end                          # 11
                             # 12
bear = Bear.new("black")     # 13
````

The above code will throw an `ArgumentError`.

On line 13, a new `Bear` object is instantiated with an argument `"black"` and assigned to the local variable `bear`.

Upon instantiation, the method `Bear#initialize` is invoked with an arguement `"black"` passed into it. The `super` keyword in the method invokes the method of the same name up in the method lookup path, which is `Animal#initialize`, and passes all arguments to it. As `Animal#initialize` does not accept any argument, Ruby throws an `ArgumentError`.

By default, the `super` keyword invokes the method of the same name up in the method lookup path, and passes all arguments passed to the method where the `super` is called. If we do not want to pass any of the given argument, we should explicitly state that like so: `super()`.

## 10

What is the method lookup path used when invoking `#walk` on `good_dog`?

````ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end
  
  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
p good_dog.walk
````

The method lookup path used when invoking `#walk` on `good_dog` is:
`GoodAnimals::GoodDog`, `Danceable`, `Swimmable`, `Animal`, `Walkable`, `Object`, `Kernel`, `BasicObject`

## 11

What is the output and why? How does this code demonstrate polymorphism?

````ruby
class Animal                                           # 1
  def eat                                              # 2
    puts "I eat."                                      # 3
  end                                                  # 4
end                                                    # 5
                                                       # 6
class Fish < Animal                                    # 7
  def eat                                              # 8
    puts "I eat plankton."                             # 9
  end                                                  # 10
end                                                    # 11
                                                       # 12
class Dog < Animal                                     # 13
  def eat                                              # 14
     puts "I eat kibble."                              # 15
  end                                                  # 16
end                                                    # 17
                                                       # 18
def feed_animal(animal)                                # 19
  animal.eat                                           # 20
end                                                    # 21
                                                       # 22
array_of_animals = [Animal.new, Fish.new, Dog.new]     # 23
array_of_animals.each do |animal|                      # 24
  feed_animal(animal)                                  # 25
end                                                    # 26
````

The above code will output:
````text
I eat.
I eat plankton.
I eat kibble.
````

On line 23, the local variable `array_of_animals` is initialized and assigned to an array of `Animal`, `Fish` and `Dog` objects.

The `Array#each` is then invoked on `array_of_animals`. Each object in the array is passed into the `feed_animal` as an argument.

Considering the implementation of `feed_animal`, it calls the `eat` method to the given argument. For each of the object in `array_of_animals`, they are of different class and each has a different implementation of `#eat`.

For `Animal` objects, the `#eat` method outputs `I eat.` to the console. While for the `Fish` and `Dog` objects, the `#eat` method outputs `I eat plankton.` and `I eat kibble.` to the console respectively.

Hence the result follows.

This code demonstrates polymorphism through inheritance. In the superclass `Animal`, a generic `#eat` method is defined. For the subclasses `Fish` and `Dog`, they override the generic `#eat` method with a more specific `#eat` method. Objects of these three types respond differently to the same method call `#eat`. That's polymorphism.

## 13

What is the output and why?

````ruby
class Animal                               # 1
  def initialize(name)                     # 2
    @name = name                           # 3
  end                                      # 4
end                                        # 5
                                           # 6
class Dog < Animal                         # 7
  def initialize(name); end                # 8
                                           # 9
  def dog_name                             # 10
    "bark! bark! #{@name} bark! bark!"     # 11
  end                                      # 12
end                                        # 13
                                           # 14
teddy = Dog.new("Teddy")                   # 15
puts teddy.dog_name                        # 16
````

The above code will output `bark! bark!  bark! bark!`.

On line 15, a new `Dog` object is instantiated and assigned to the local variable `teddy`.

On line 16, the `dog_name` method is called on the `Dog` object that `teddy` references. However, as the instance variable `@name` is never initialized, it references `nil` at the moment. Therefore the line 16 will output `bark! bark!  bark! bark!` to the console.
