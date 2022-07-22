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

On line 9, a new `Person` object is instantiated and assigned to the local variable `bob`. The `Person` class has an instance variable `@name` defined for all its instances. However, it is not initialized upon instantiation. The instance variable `@name`, unlike local variables, points to `nil`. For local varables, a `NameError` will be thrown when called if it is uninitialized.

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

On line 15, a new `Dog` object is instantiated and assigned to the local variable `teddy`. The `Dog` class has an instance variable `@can_swim` defined. However, it is not initialized until the instance method `enable_swimming` is invoked. Instance variables point to `nil` if they are not initialized. Therefore, when the instance method `#swim` is called on the `Dog` object that `teddy` references, it returns `nil` to the console.
