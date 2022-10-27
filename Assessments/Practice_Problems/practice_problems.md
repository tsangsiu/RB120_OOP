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

### Attempt 1

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

### Attempt 2

on line 25, the class method `sides` is called on the `Square` class. As the `::sides` method is not defined in the `Square` class, Ruby looks for it up in the method lookup path and invokes `::sides` in the `Shape` class. Upon the invocation of `::sides`, it returns `self::SIDES`. As the `self` here is inside a class method, it refers to the calling class which calls the `::sides` method, which is `Square`. To resolve the constant `Square::SIDES`, Ruby first search for it in the lexical scope (in the `Square` class). As there is no `SIDES` constant defined in `Square` class, Ruby then looks for it up in the method lookup path and finds it in the `Quadrilateral` class. Therefore `self::SIDES` is resolved to `4`, which is then outputted to the console.

On line 26, the instance method `sides` is called on a `Square` object. As the `#sides` method is not defined in the `Square` class, Ruby looks for it up in the method lookup path and invokes `#sides` in the `Shape` class. Upon the invocation of `#sides`, it returns `self.class::SIDES`. As the `self` here is inside an instance method, it refers to the calling object which calls the `#sides` method, and thus `self.class` returns the class of the calling object, which is `Square`. By the same token as above, `Square::SIDES` is resolved to `4`, which is then outputted to the console.

On line 27, the instance method `describe_shape` is called on a `Square` object. As the `describe_shape` method is not defined in the `Square` class, Ruby looks for it up in the method lookup path and invokes the `describe_shape` method in the `Describable` module, which is mixed in the `Shape` class via mixin. Upon the invocation of `describe_shape`, it returns `"I am a #{self.class} and have #{SIDES} sides."`. As the `self` here is inside an instance method, it refers to the calling object which calls the `describe_shape` method. Therefore `self.class` resolves to `Square`. To resolve the constant `SIDES`, Ruby first looks for it in the lexical scope of where it is referenced (in the `Describable` module). As the constant is not defined in the `Describable` module, Ruby then looks for it up in the method lookup path of the `Describable` module and then finally in the main scope. As Ruby still cannot find the constant, it raises `NameError`, and thus line 27 raises `NameError`. 

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

### Attempt 1

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

### Attempt 2

The line 38 outputs an array of `Animal` objects to the console.

Considering the return value of the `#+` method in other classes, `1 + 1` returns `2`, `"Hello" + " " + "World!"` returns `"Hello World!`, and `[1, 2, 3] + [4, 5]` returns `[1, 2, 3, 4, 5]`. We notice that the `+` method returns an object of the same type as the calling object and the arguments. So, we would expect the `AnimalClass#+` method return an `AnimalClass` object. However, the `+` method in the above code returns an object of a different type.

In order to be more in line with what we'd expect the method to return, we could modify the `AnimalClass#+` method as follows:

````ruby
def +(other_class)
  return_obj = AnimalClass.new('New Animal Class')
  return_obj.animals = animals + other_class.animals
  return_obj
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

### Attempt 1

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

### Attempt 2

On line 9, the class method `wheels` is invoked on the class `Vehicle`. Upon the invocation of `Vehicle::wheels`, it returns `@@wheels`, which is `4`. Therefore line 9 outputs `4` to the console.

On lines 11 to 13, a subclass of `Vehicle` called `Motorcycle` is defined. As a class and all its subclasses share only one copy of class variable, inside the class `Motorcycle`, the class variable is re-assigned to `2`. Therefore, when the class method `wheels` is invoked on the classes `Motorcycle` and `Vehicle` on lines 15 and 16, they both return `2`. So, both lines 15 and 16 output `2` to the console.

On line 18, a subclass of `Vehicle` called `Car` is defined. The `Car` can also access the same class variable `@@wheels`. At this point on line 18, the class variable `@@wheels` points to `2`. Therefore when the class method `::wheels` method (which returns `@@wheels`) is invoked on the classes `Vehicle`, `Motorcycle` and `Car` on lines 20 to 22, they all return `2`. So lines 20 to 22 output `2` to the console.

As a class and all its subclasses share only one copy of a class variable, a class variable defined in a class can easily be overridden by its subclasses. Therefore, we should avoid using class variables when working with inheritance.

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

### Attempt 1

The above code will output the information about the `GoodDog` object that `bruno` references, which includes the encoding of the object ID and the attributes of the `GoodDog` object. The attributes include two instance variables: `@name` and `@color`, where both reference the string `"brown"`.

On line 16, a new `GoodDog` is instantiated with an argument `"brown"` and assigned to the local variable `bruno`.

Upon instantiation, the method `GoodDog#initialize` is invoked with an argument `"brown"`. The `super` keyword inside the method invokes the method of the same name up in the method lookup path, which is `Animal#initialize`, and passes all arguments to it. Therefore, the instance variable `@name` is assigned to the string `"brown"`. Back to the method `GoodDog#initialize`, the instance variable `@color` is assigned to the string `"brown"`.

Hence the output follows.

### Attempt 2

The above code outputs a string representation of a `GoodDog` object, with attributes `@name = "brown"` and `@color = "brown"`.

On line 16, a new `GoodDog` object is instantiated and assigned to the local variable `bruno`. The method invocation of `new` on the `GoodDog` class triggers the invocation of `GoodDog#initialize`. Upon the method invocation of `GoodDog#initialize` with an argument `"brown"`, the `super` keyword invokes the method of the same name in the superclass, which is `Animal#initialize`, and passes all arguments to it. The instance variable `@name` is then initialized to the string `"brown"`. On line 12, the instance variable `@color` is initialized to the string `"brown"`. Therefore, after instantiation, a new `GoodDog` object with attributes `@name = "brown"` and `@color = "brown"` is instantiated.

With the only keyword `super`, it calls the method of the same name in the superclass and passes all arguments that are passed to the current method to it.

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

### Attempt 1

The above code will throw an `ArgumentError`.

On line 13, a new `Bear` object is instantiated with an argument `"black"` and assigned to the local variable `bear`.

Upon instantiation, the method `Bear#initialize` is invoked with an arguement `"black"` passed into it. The `super` keyword in the method invokes the method of the same name up in the method lookup path, which is `Animal#initialize`, and passes all arguments to it. As `Animal#initialize` does not accept any argument, Ruby throws an `ArgumentError`.

By default, the `super` keyword invokes the method of the same name up in the method lookup path, and passes all arguments passed to the method where the `super` is called. If we do not want to pass any of the given argument, we should explicitly state that like so: `super()`.

### Attempt 2

The line 13 will raise `ArgumentError`.

On line 13, a new `Bear` object is attempted to be instantiated. The class method `::new` is invoked on the class `Bear` with an argument `"black"`. The invocation of `::new` trigger the invocation of `Bear#initialize`. Upon the invocation of `Bear#initialize`, the keyword `super` invokes the method of the same name in the superclass, which is `Animal`, and passes all arguments that is passed to `Bear#initialize` (which is `"black"`) to `Animal#initialize`. However, `Animal#initialize` does not accept any arguments, hence raising `ArgumentError`.

This demonstrates that the `super` keyword invokes the method of the same name in the superclass and passes all arguments that are passed to the current method to it. If we wish to pass no arguments to the method of the same name in the superclass, we should explicitly state like so: `super()`.

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
`GoodAnimals::GoodDog`, `Danceable`, `Swimmable`, `Animal`, and finally `Walkable` where the `#walk` method is found.

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

### Attempt 1

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

### Attempt 2

The above code will output the following to the console:

````text
I eat.
I eat plankton.
I eat kibble.
````

Polymorphism means objects of different types respond to the same method invocation.

On line 23, an array containing objects of different types is initialized and assigned to the local variable `array_of_animals`. We then iterate through the array. Each object in the array is passed into the method `feed_animal`. Upon the method invocation of `feed_animal`, the `eat` method in called on the object that is passed into the `feed_animal` method.

Let's consider each object in the array one by one. The first one is an `Animal` object. There is an `eat` method defined in the `Animal` class, which outputs `I eat.` to the console when invoked. The second one is a `Fish` object. The `Fish` class overrides the `eat` method in the `Animal` class, and the `Fish#eat` method outputs `I eat plankton.` to the console when invoked. The third one is a `Dog` object. The `Dog` class overrides the `eat` method in the `Animal` class, and the `Dog#eat` method outputs `I eat kibble.` to the console when invoked. Hence the output in the above follows.

When we invoke the `eat` method on each of the object in the array referenced by `array_of_animals`, we do not care about the object type, as long as the object has the compatible `eat` method that accepts no argument. That is polymorphism in action. More specifically, that's polymorphism through inheritance. It is because the `Fish` and `Dog` classes override the `eat` method from their parent class: the `Animal` class.

## 12

The below code raises an error. Why? What do `kitty` and `bud` represent in relation to our `Person` object?

````ruby
class Person                     # 1
  attr_accessor :name, :pets     # 2
                                 # 3
  def initialize(name)           # 4
    @name = name                 # 5
    @pets = []                   # 6
  end                            # 7
end                              # 8
                                 # 9
class Pet                        # 10
  def jump                       # 11
    puts "I'm jumping!"          # 12
  end                            # 13
end                              # 14
                                 # 15
class Cat < Pet; end             # 16
                                 # 17
class Bulldog < Pet; end         # 18
                                 # 19
bob = Person.new("Robert")       # 20
                                 # 21
kitty = Cat.new                  # 22
bud = Bulldog.new                # 23
                                 # 24
bob.pets << kitty                # 25
bob.pets << bud                  # 26
                                 # 27
bob.pets.jump                    # 28
````

On line 20, a new `Person` with the attributes `@bane = "Robert"` and `@pets = []` is instantiated and assigned to the local variable `bob`.

On lines 22 and 23, a new `Cat` and a new `Bulldog` object are instantiated and assigned to the local variables `kitty` and `bud` respectively. Both objects inherit the `jump` method from their parent class `Pet`.

On lines 25 and 26, the objects referenced by `kitty` and `bub` are appended to an empty array referenced by the instance variable `@pets` of the `Person` object referenced by `bob`. At this point, the instance variable `@pet` points to an array containing one `Cat` and one `BullDog` object.

Therefore, when we invoke the `jump` method on the array returned by `bob.pets` (where `pets` is a getter of the instance variable `@pets`), it raises `NoMethodError` because there is no `jump` method defined in the `Array` class.

In the above code example, the objects referenced by the local variables `kitty` and `bud` are stored as a state in an instance variable of a `Person` object `bob`. Therefore, `bob`, `kitty` and `bud` are collaborator objects.

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

### Attempt 1

The above code will output `bark! bark!  bark! bark!`.

On line 15, a new `Dog` object is instantiated and assigned to the local variable `teddy`.

On line 16, the `dog_name` method is called on the `Dog` object that `teddy` references. However, as the instance variable `@name` is never initialized, it references `nil` at the moment. Therefore the line 16 will output `bark! bark!  bark! bark!` to the console.

### Attempt 2

On line 15, the class method `::new` is invoked on the class `Dog`. This triggers the invocation of `Dog#initialize` with an argument `"Teddy"`. The `Dog` object is then assigned to the local variable `teddy`. The `Dog` object has no attributes initailized, because no instance variable is initialized in the `Dog#initialize` method.

When we invoke `dog_name` on `teddy`, it returns `"bark! bark! #{@name} bark! bark!"`. As `@name` is not initialized, `@name` point to `nil`, and thus line 16 outputs `bark! bark!  bark! bark!` to the console.

## 14

In the below code, we want to compare whether the two objects have the same name. The line 11 currently returns `false`. How could we return `true` on line 11?

Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?

````ruby
class Person                       # 1
  attr_reader :name                # 2
                                   # 3
  def initialize(name)             # 4
    @name = name                   # 5
  end                              # 6
end                                # 7
                                   # 8
al = Person.new('Alexander')       # 9
alex = Person.new('Alexander')     # 10
p al == alex # => true             # 11
````

On line 11, the `#==` method is the method inherits from the `BasicObject` class which compares if the two objects in question are the same object. As `al` and `alex` point to different objects, `al == alex` returns `false`. To make it return `true` on line 11, we can compare the `@name` attributes of both objects, which have the same name. This leads us to define our own `#==` method in the `Person` class which compares the instance variables `@name`. The following `#==` method can be added to the `Person` class:

````ruby
def ==(other_person)
  @name == other_person.name
end
````
The fact that `al.name == alex.name` returns `true` does not mean that the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object. It is because the `String#==` method overrides the `BasicObject#==` method. The `String#==` is defined to compare if the two `String` objects have the same value, rather than if they are the same `String` object. The following code snippet can be used to prove our case:

````ruby
al.name == alex.name # => true

al.name.object_id == alex.name.object_id # => false
al.name.equal?(alex.name) # => name
````

## 15

What are the outputs on lines 14, 15 and 16, and why?

````ruby
class Person                          # 1
  attr_reader :name                   # 2
                                      # 3
  def initialize(name)                # 4
    @name = name                      # 5
  end                                 # 6
                                      # 7
  def to_s                            # 8
    "My name is #{name.upcase!}."     # 9
  end                                 # 10
end                                   # 11
                                      # 12
bob = Person.new('Bob')               # 13
puts bob.name                         # 14
puts bob                              # 15
puts bob.name                         # 16
````

The following will output to the console:

````text
Bob
My name is BOB.
BOB
````

On line 13, a new `Person` object with an attribute `@name = 'Bob'` is instantiated and assigned to the local variable `bob`.

On line 14, the getter of the instance variable `@name` is called on `bob`. Therefore `bob.name` returns `'Bob'`, and hence it is outputted to the console by the `puts` method.

On line 15, the `puts` method is invoked with the `Person` object referenced by `bob` as an argument. The `puts` implicitly invokes `to_s` on its argument before outputting the return value to the console. When `to_s` is invoked on `bob`, the instance variable `@name` is mutated to `'BOB'` and returns `"My name is BOB."`, and hence it is outputted to the console by the `puts` method.

At this point, the instance variable `@name` points to the string `'BOB'`. Therefore, when we invoke the getter of `@name` on `bob`, it returns `'BOB'`, and hence it is outputted to the console by the `puts` method.

## 16

Why is it generally safer to invoke a setter method than to reference the instance variable directly when trying to set an instance variable within the class? Give an example.

When trying to set an instance variable within a class, it is generally safer to invoke a setter method than to reference the instance variable directly because a setter allows us to perform data check. That being said, invoking a setter when assigning a value to an instance variable can make sure that the value assigned is valid.

Take the following code snippet as an example, when we attempt to assign a negative value to the age of a person, the value is not assigned to `@age` as negative values fail the data check. The value is successfully assigned to `@age` when it passes the data check.

````ruby
class Person
  attr_accessor :name
  attr_reader :age

  def initialize(name)
    @name = name
  end
  
  def age=(age)
    @age = age if age >= 0 && age <= 120
  end
end

jason = Person.new('Jason')

jason.age = -1
p jason.age # => nil

jason.age = 30
p jason.age # => 30
````

If we do not use a setter, we can then assign any value we want to `@age`. Therefore, it is generally safer to invoke a setter method than to reference the instance variable directly when trying to set an instance variable within the class.

````ruby
class Person
  attr_accessor :name, :age

  def initialize(name)
    @name = name
  end
end

jason = Person.new('Jason')

jason.age = -1
p jason.age # => -1

jason.age = 'age'
p jason.age # => 'age'
````

## 17

Given an example of when it would make sense to manually write a custom getter method than to use `attr_reader`.

A custom getter method can give us control over the return value, while the getter method given by `attr_reader` cannot.

Sometimes when accessing sensitive data like ID number, it would make sense to hide some of the digits. We can write our custom getter method to do so:

````ruby
class Person
  attr_accessor :name

  def initialize(name, id)
    @name = name
    @id = id
  end
  
  def id
    "#{@id[0..2]}#{'X' * @id[3..].length}"
  end
end

jason = Person.new('Jason', 'A123456789')
p jason.id # => 'A12XXXXXXX'
````

Also, we only mask the ID number once in the custom getter method of `@id`, instead of masking it every time when it is referecend.

If we use the getter given by `attr_reader`, the unmasked ID will be returned, which is not ideal:

````ruby
class Person
  attr_accessor :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end
end

jason = Person.new('Jason', 'A123456789')
p jason.id # => 'A123456789'
````

## 18

What does executing `Triangle.sides` return? What does executing `Triangle.new.sides` return? What does this demonstrate about class variables?

````ruby
class Shape                     # 1
  @@sides = nil                 # 2
                                # 3
  def self.sides                # 4
    @@sides                     # 5
  end                           # 6
                                # 7
  def sides                     # 8
    @@sides                     # 9
  end                           # 10
end                             # 11
                                # 12
class Triangle < Shape          # 13
  def initialize                # 14
    @@sides = 3                 # 15
  end                           # 16
end                             # 17
                                # 18
class Quadrilateral < Shape     # 19
  def initialize                # 20
    @@sides = 4                 # 21
  end                           # 22
end                             # 23
````

Executing `Triangle.sides` will return `nil`.

Executing `Triangle.new.sides` will return `3`.

In the above code, a class named `Shape` is defined. Two subclasses of `Shaped`, naming `Triangle` and `Quadrilateral`, are also defined.

When we invoke the class method `sides` on the class `Triangle`, `Shape::sides` is invoked as there is no `::sides` method defined in the `Triangle` class and Ruby then looks for the method up in the method lookup path. The `Shape::sides` returns `@@sides` which points to `nil` at the moment.

When we invoke the instance method `sides` on a `Triangle.new`, the method `Triangle#initialize` is triggered to be invoked which re-assigns the class variable `@@sides` to `3`. As a superclass and all its subclasses share the same copy of class variable, when we call the instance method `sides` on a `Triangle` object which returns `@@sides`, it returns `3`.

The above code demonstrates that a superclass and all its subclasses share the same copy of class variable, and thus the value referenced by a class variable in a superclass can be manipulated by its subclasses.

## 19

What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.

## 20

What is the difference between states and behaviors?

A state of an object tracks its attributes, while behaviors are what an object capable of doing.

Different objects have different states, but objects of the same type share the same behaviors.

## 21

What is the difference between instance methods and class methods?

An instance method is a method invoked on an object. They can access and manipulate the caller object's states, and even class variables.

In contrast, a class method can be invoked on the class itself, without instantiating any objects. They can access and manipulate class variables, but not for instance variables.

## 22

What are collaborator objects, and what is the purpose of using them in OOP? Given an example of how we would work with one.

A collaborator object is an object that is stored as a state of another object. A collaborator object is usually a custom object, although objects of built-in types such as strings and arrays are technically collaborator objects.

By creating collaborator objects, objects of different types can work together and build association. In other way, a problem can be broken down into cohesive pieces that work together.

For example, in a library, there is a collection of books. We can consider `Book` objects to be collaborator objects to a `Library` object. It is because `Book` and `Library` are separate objects, and they work meaningfully in a collaborative way. When we need a `Book` object to perform some actions, we can go through a `Library` object and invoke the concerned method on the instance variable which stores the `Book` object or on each `Book` object in a collection.

````ruby
class Library
  attr_accessors :books

  def initialize
    @books = []
  end

  def <<(book)
    books << book
  end

  def display_collection
    books.each { |book| puts book}
  end
end

class Book
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "#{title} by #{author}"
  end
end

library = Library.new

atomic_habits = Book.new('Atomic Habits', 'James Clear')
rich_dad_poor_dad = Book.new('Rich Dad Poor Dad', 'Robert Kiyosaki')
harry_potter = Book.new('Harry Potter', 'J.K. Rowling')

library << atomic_habits
library << rich_dad_poor_dad
library << harry_potter

library.books.each { |book| puts book }
# => Atomic Habits by James Clear
# => Rich Dad Poor Dad by Robert Kiyosaki
# => Harry Potter by J.K. Rowling
````

## 25

What does the below code demonstrate about how instance variables are scoped?

````ruby
class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

p bob.get_name # => "bob"
````

In the above code, two `Person` objects with attributes `@name = 'bob'` and `@name = 'joe'` are instantiated and assigned to the local variables `bob` and `joe` respectively.

When we invoke the `get_name` method on `bob`, it returns `'bob'` which is the value referenced by `@name` of the `Person` object referenced by `bob`. This shows that instance variables are scoped at object level. The same instance variable of different objects are not cross over from each other.

## 28

````ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky
````

What is the output and why? How could we output a message of our choice instead?

How is the output above different than the output of the code below, and why?

````ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky
````

For the first code snippet, it outputs the string representation of the `GoodDog` object referced by `sparky`, which by default contains the class name `GoodDog` and the encoding object ID.

To output a message of our choice instead, we should define our custom `to_s` method which returns the message of our choice in the `GoodDog` class.

For the second code snippet, besides the class name `GoodDog` and the encoding object ID, it also outputs the state of the `GoodDog` object referenced by `sparky` (`@name = 'Sparky'` and `@age = 28`). It is because while the `puts` method implicitly invoke `to_s` on the argument before outputting the result to the console, the `p` method implicitly invoke `inspect` on the argument.

## 34

````ruby
module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

mike = Person.new("Mike")
p mike.walk

kitty = Cat.new("Kitty")
p kitty.walk
````

What is returned/output in the code? Why did it make more sense to use a module as a mixin than defining a parent class and using class inheritance?

The above code outputs the following to the console:

````text
"Mike strolls forward"
"Kitty saunters forward"
````

It makes more sense to use a module as a mixin here (interface inheritance) because both `Person` and `Cat` *has* the ability to walk, and they do not have a meaningful parent class to inherit from.

## 38

````ruby
class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new
````

If we use `==` to compare the individual `Cat` objects in the code above, will the return value be `true`? Why or why not? What does this demonstrate about classes and objects in Ruby, as well as the `==` method?

By default, the `==` method (inherited from the `BasicObject` class) compares the object IDs of the calling object and the argument. As `whiskers`, `ginger` and `paws` reference three distinct `Cat` object, if we use `==` to compare the individual `Cat` objects, the return value will not be `true`.

The above code demonstrates that classes are like molds which can create many objects of the same kind. Also, the above code demonstrates that if we do not have our custom `==` method defined in a class, the class inherits the `==` method from the `BasicObject` class which compares the objects' object IDs.

## 39

````ruby
class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end
````

Describe the inheritance structure in the code above, and identify all the superclasses.

The class `SomethingElse` inherits the class `AnotherThing`, which inherts the class `Thing`.

There are two superclasses, namely `AnotherThing` and `Thing`.

## 40

````ruby
module Flight
  def fly; end
end

module Aquatic
  def swim; end
end

module Migratory
  def migrate; end
end

class Animal
end

class Bird < Animal
end

class Penguin < Bird
  include Aquatic
  include Migratory
end

pingu = Penguin.new
pingu.fly
````

What is the method lookup path that Ruby will use as a result of the call to the `fly` method? Explain how we can verify this.

The method lookup path that Ruby will use when we call the `fly` method is `[Penguin, Migratory, Aquatic, Bird, Animal, Object, Kernel, BasicObject]`.

To verify this, we can ruby the below code:

````ruby
p Penguin.ancestor
# => [Penguin, Migratory, Aquatic, Bird, Animal, Object, Kernel, BasicObject]
````

## 41

````ruby
class Animal                     # 1
  def initialize(name)           # 2
    @name = name                 # 3
  end                            # 4
                                 # 5
  def speak                      # 6
    puts sound                   # 7
  end                            # 8
                                 # 9
  def sound                      # 10
    "#{@name} says "             # 11
  end                            # 12
end                              # 13
                                 # 14
class Cow < Animal               # 15
  def sound                      # 16
    super + "moooooooooooo!"     # 17
  end                            # 18
end                              # 19
                                 # 20
daisy = Cow.new("Daisy")         # 21
daisy.speak                      # 22
````

What does this code output and why?

The above code will output `Daisy says moooooooooooo!` to the console.

On line 21, a new `Cow` object is instantiated and assigned to the local variable `daisy`. The invocation of the class method `new` on the class `Cow` triggers the invocation of `Animal#initialize` (as the `initialize` method is not defined in the `Cow` class) and the instance variable `@name` is initialized to `"Daisy"`.

On line 22, the method `speak` is invoked on the `Cow` object referenced by `daisy`. As there is no `speak` method defined in the `Cow` class, Ruby looks for the method in its superclass and invokes `Animal#speak`. The `Animal#speak` method outputs the value returned by `sound` to the console. Ruby then invokes `Cow#sound`. Upon invocation, the `super` keyword call the method of the same name in the superclass, which is the `Animal#sound` method. The `Animal#sound` method returns `"Daisy says "`. Appended `"moooooooooooo!"`, `"Daisy says moooooooooooo!"` is the return string by the `Animal#sound` method. Therefore, line 22 outputs `"Daisy says moooooooooooo!"` to the console.

## 42

````ruby
class Cat
  def initialize(name, coloring)
    @name = name
    @coloring = coloring
  end

  def purr; end

  def jump; end

  def sleep; end

  def eat; end
end

max = Cat.new("Max", "tabby")
molly = Cat.new("Molly", "gray")
````

Do `molly` and `max` have the same states and behaviors in the code above? Explain why or why not, and what this demonstrates about objects in Ruby.

In Ruby, objects of the same class share the same behaviours, while they could have different states.

A state of an object is the combination of all attributes. In the above code example, the `Cat` object referenced by `max` has the state of `@name = 'Max'` and `@coloring = 'tabby'`, while that by `molly` has the state of `@name = 'Molly` and `@coloring = 'gray'`. Those two objects have different states.

However, as `max` and `molly` are `Cat` objects, they share the same behaviors. They have access to the `purr`, `jump`, `sleep` and `eat` methods.

# 43

````ruby
class Student                     # 1
  attr_accessor :name, :grade     # 2
                                  # 3
  def initialize(name)            # 4
    @name = name                  # 5
    @grade = nil                  # 6
  end                             # 7
                                  # 8
  def change_grade(new_grade)     # 9
    grade = new_grade             # 10
  end                             # 11
end                               # 12
                                  # 13
priya = Student.new("Priya")      # 14
priya.change_grade('A')           # 15
priya.grade                       # 16
````

In the above code snippet, we want to return `"A"`. What is actually returned and why? How could we adjust the code to produce the desired result?

On line 14, a new `Student` object with an attributes `@name = Priya'` and `@grade = nil` is instantiated and assigned to the local variable `priya`.

On line 15, the `change_grade` method is invoked on `priya` with an argument `'A'`. The intention is the change the value referenced by the instance variable `@grade` to `'A'` by utilizing its setter method provided by `attr_accessor`. However, without the prefix `self.`, Ruby will take it as local variable initialization rather than calling the setter method. Therefore, the value referenced by `@grade` remains unchanged.

When the getter of `@grade` is called on `priya` on line 16, it therefore returns `nil`.

To produce the desired result, we should modify the `change_grade` method as follows:

````ruby
def change_grade(new_grade)
  self.grade = new_grade
end
````

## 44

````ruby
class MeMyselfAndI       # 1
  self                   # 2
                         # 3
  def self.me            # 4
    self                 # 5
  end                    # 6
                         # 7
  def myself             # 8
    self                 # 9
  end                    # 10
end                      # 11
                         # 12
i = MeMyselfAndI.new     # 13
````

What does each `self` refer to in the above code snippet?

Inside a class method, `self` refers to the class. Inside an instance method, `self` refers to the object that calls the method. Elsewhere, `self` refers to the enclosing structure.

On line 5, the `self` refers to the class `MeMyselfAndI`.

On line 9, the `self` refers to the object that calls the `myself` method.

On lines 2 and 4, the `self` refers to the enclosing structure which is the class `MeMyselfAndI`.

## 45

Running the following code will not produce the output shown on the last line. Why not? What would we need to change, and what does this demonstrate about instance variables?

````ruby
class Student
  attr_accessor :grade

  def initialize(name, grade=nil)
    @name = name
  end 
end

ade = Student.new('Adewale')
p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">
````

In the above code, a new `Student` object is instantiated. The `new` method is invoked on the class `Student` with an argument `'Adewale'`. This triggers the method invocation of `Student#initialize`. Upon the invocation of `Student#initialize`, the method parameter `name` is assigned to `'Adewale'` and `grade` is defaulted to `nil`. The instance variable `@name` is then initialized and assigned to the value that `name` is referencing, which is `'Adewale'`. The value referenced by `grade` (`nil`) is not used by the method, and the instance variable `@grade` is not initialized. Therefore, when we inspect the `Student` object referenced by `ade`, `@grade` is not an attribute of the object.

In Ruby, in order to let an object to have an attribute. The method that initializes the attribute (or instance variable) must first be invoked.

Therefore, in order to produce the output as shown, we should amend the `initialize` method as follows:

````ruby
def initialize(name, grade = nil)
  @name = name
  @grade = grade
end
````

## 46

````ruby
class Character                         # 1
  attr_accessor :name                   # 2
                                        # 3
  def initialize(name)                  # 4
    @name = name                        # 5
  end                                   # 6
                                        # 7
  def speak                             # 8
    "#{@name} is speaking."             # 9
  end                                   # 10
end                                     # 11
                                        # 12
class Knight < Character                # 13
  def name                              # 14
    "Sir " + super                      # 15
  end                                   # 16
end                                     # 17
                                        # 18
sir_gallant = Knight.new("Gallant")     # 19
p sir_gallant.name                      # 20
p sir_gallant.speak                     # 21
````

What is output and return value, and why? What would we need to change so that the last line outputs `"Sir Gallant is speaking."`?

On line 19, a new `Knight` object is instantiated and assigned to the local variable `sir_gallant`. The class method `new` is invoked on the class `Knight` with an argument `"Gallant"`. This triggers the method invocation of `Character#initialize` as there is no `initialize` method defined in the `Knight` class. Upon the invocation of `Character#initialize`, the instance variable `@name` is initialized to `"Gallant"`.

On line 20, the `name` method is invoked on `sir_gallant`. Upon the invocation of `Knight#name`, the `super` keyword calls the method of the same name in the superclass, which is `Character#name`. The method `Character#name` is a getter of `@name` given by `attr_accessor` and thus returns `"Gallant`. Prefixed by `"Sir "`, `sir_gallant.name` returns `"Sir Gallant"` and is then outputted to the console by the `p` method.

On line 21, the `speak` method is invoked on `sir_gallant`. Upon the invocation of `Character#speak` (as there is no `speak` method defined in the `Knight` class), it returns `"Gallant is speaking."` as `@name` points to `"Gallant"` at the moment. The string `"Gallant is speaking."` is then outputted to the console by the `p` method.

To change the code so that the last line outputs `"Sir Gallant is speaking."`, we can amend the `Character#speak` method as follows:

````ruby
def speak
  "#{name} is speaking."
end
````

It is because we know that `sir_gallant.name` returns `"Sir Gallant"`.

## 47

What is the output and why?

````ruby
class FarmAnimal             # 1
  def speak                  # 2
    "#{self} says "          # 3
  end                        # 4
end                          # 5
                             # 6
class Sheep < FarmAnimal     # 7
  def speak                  # 8
    super + "baa!"           # 9
  end                        # 10
end                          # 11
                             # 12
class Lamb < Sheep           # 13
  def speak                  # 14
    super + "baaaaaaa!"      # 15
  end                        # 16
end                          # 17
                             # 18
class Cow < FarmAnimal       # 19
  def speak                  # 20
    super + "mooooooo!"      # 21
  end                        # 22
end                          # 23
                             # 24
p Sheep.new.speak            # 25
p Lamb.new.speak             # 26
p Cow.new.speak              # 27
````

The following is outputted to the console:

````ruby
"#<Sheep:0x000000000294a3e8> says baa!"
"#<Lamb:0x000000000294a1e0> says baa!baaaaaaa!"
"#<Cow:0x000000000294a000> says mooooooo!"
````

On line 25, the `speak` method is invoked on the `Sheep` object `Sheep.new`. Upon the method invocation of `Sheep#speak`, the `super` keyword calls the method of the same name in the superclass `FarmAnimal`. The `FarmAnimal#speak` method returns `#{self} says `. As the `self` here is inside an instance method, it refers to the object that call the method, which is the `Sheep` object `Sheep.new`. In order to get `self` interpolated into a string, the `to_s` method is invoked on `self`. As there is no `to_s` method defined in the `Sheep` and `FarmAnimal` class, by default, `to_s` returns the class of the calling object and the encoding of its object ID. Therefore, `FarmAnimal#speak` returns `"#<Sheep:0x000000000294a3e8> says "`. Appended with `"baa!"`, `Sheep.new.speak` returns `""#<Sheep:0x000000000294a3e8> says baa!""`, which is then outputted to the console by the `p` method.

By the same token, lines 26 and 27 output `"#<Lamb:0x000000000294a1e0> says baa!baaaaaaa!"` and `"#<Cow:0x000000000294a000> says mooooooo!"` respectively to the console.

## 48

````ruby
class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)
````

What are the collaborator objects in the above code snippet, and what makes them collaborator objects?

In the above code, the `Person` object referenced by `sara` is a collaborator object. It is a collaborator object because it is stored as a state in other object referenced by `fluffy`.

Technically, the strings `"Sara"` and `"Fluffy"` are also collaborator objects, but by collaborator objects we usually refer to custom objects.

## 50

````ruby
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end
````

What are the scopes of each of the different variables in the above code?

## 52

````ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
````

In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix? Which use case would be preferred according to best practices in Ruby, and why?

## 53

````ruby
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
````

What is the output and why? What does this demonstrate about how methods need to be defined in modules, and why?
