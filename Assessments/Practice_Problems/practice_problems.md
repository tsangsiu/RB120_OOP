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

On line 9, a new `Person` object is instantiated and assigned to the local variable `bob`. The `Person` class has an instance variable `@name` defined for all its instances. However, it is not initialized upon instantiation. Unlike local variables, Ruby treats the uninitialized `@name` as if it points to the value `nil`. For local varables, a `NameError` will be thrown when called if it is uninitialized.

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

On line 15, a new `Dog` object is instantiated and assigned to the local variable `teddy`. The `Dog` class has an instance variable `@can_swim` defined. However, it is not initialized until the instance method `enable_swimming` is invoked. Ruby treats the uninitialized `@can_swim` as if it references `nil`. Therefore, when the instance method `#swim` is called on the `Dog` object that `teddy` references, it returns `nil` to the console.

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