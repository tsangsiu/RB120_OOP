# Practice Problems by Marwan Zaarab

## 1

What will the following code output? Why?

````ruby
class Student                # 1
  attr_reader :id            # 2
                             # 3
  def initialize(name)       # 4
    @name = name             # 5
    @id                      # 6
  end                        # 7
                             # 8
  def id=(value)             # 9
    self.id = value          # 10
  end                        # 11
end                          # 12
                             # 13
tom = Student.new("Tom")     # 14
tom.id = 45                  # 15
````

The above code will raise `SystemStackError`.

On line 14, a new `Student` object with an attribute `@name = 'Tom'` is instantiated and assigned to the local variable `tom`.

On line 15, the setter method `id=` which recursively calls itself is invoked on `tom`. Hence raising `SystemStackError`.

## 2

Define a class of your choice with the following:

- A constructor method that initializes 2 instance variables
- An instance method that outputs an interpolated string of those variables
- Getter methods for both (you can use the shorthand notation if you want)
- To prevent instances from accessing these methods outside of the class

Finally, explain what concept(s) you’ve just demonstrated with your code.

````ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def greet
    puts "Hi! I'm #{name}. I'm #{age} years old."
  end
  
  private
  
  attr_reader :name, :age
end
````

The above code demonstrates the concept of encapsulation. Encapsulation means restricting the direct access of instance variables and methods, and exposing public interfaces that users of the object need.

In the above code, we encapsulate the instance variables `@name` and `@age` and their getters. Users of an `Person` object cannot directly obtain the values referenced by `@name` and `@age`. Instead, we provide a more meaningful public interface called `Person#greet` that users can access which outputs a string interpolating the values referenced by `@name` and `@age`.

## 3

What concept does the following code aim to demonstrate?

````ruby
module Greet
  def greet(message)
    puts message
  end
end

class Teacher
  include Greet
end

class Student
  include Greet
end

tom = Teacher.new
rob = Student.new

tom.greet "Bonjour!"
rob.greet "Hello!"
````

The above code demonstrates the concept of polymorphism through interface inheritance.

Polymorphism means objects of different type respond to the same method invocation.

In the above code, `tom` and `rob` point to two different types of objects, namely `Teacher` and `Student` respectively. However, they both respond to the same method invocation `greet`. The `greet` method is mixed in the `Teacher` and `Student` classes via mixin, which is the reason why both `Teacher` and `Student` objects can respond to the method invocation of `greet`.

## 4

What will the last line of code return?

````ruby
class Student                     # 1
  def initialize(id, name)        # 2
    @id = id                      # 3
    @name = name                  # 4
  end                             # 5
                                  # 6
  def ==(other)                   # 7
    self.id == other.id           # 8
  end                             # 9
                                  # 10
  private                         # 11
                                  # 12
  attr_reader :id, :name          # 13
end                               # 14
                                  # 15
rob = Student.new(123, "Rob")     # 16
tom = Student.new(456, "Tom")     # 17
                                  # 18
rob == tom                        # 19
````

The last line of the above code will raise `NoMethodError`.

On lines 16 and 17, two `Student` objects with attributes `@id = 123` and `@name = 'Rob'`, and `@id = 456` and `@name = 'Tom'` are instantiated.

On line 19, the `#==` method is invoked on `rob` which attempts to compare the instance variables `@id` of both objects. However, as the getter of `@id` is a private method, it can only be accessed inside the object. Therefore `tom.id` raises `NoMethodError` inside the object referenced by `rob`. Hence the result follows.

## 5

What will the last 2 lines of code output?

````ruby
class Foo
  def self.method_a
    "Justice" + all
  end

  def self.method_b(other)
    "Justice" + other.exclamate
  end

  private

  def self.all
    " for all"
  end

  def self.exclamate
    all + "!!!"
  end
end

foo = Foo.new
puts Foo.method_a
puts Foo.method_b(Foo)
````

On the second last line, the class method `method_a` is invoked on the class `Foo`. Upon the invocation of `method_a`, Ruby resolves `all`. As there is no local variable `all` defined in the method, Ruby looks for a class method named `all` as `all` is referenced inside a class method. Therefore, `all` is resolved to `' for all'`, and hence `Foo.method_a` returns `"Justice for all"` which is then outputted to the console.

