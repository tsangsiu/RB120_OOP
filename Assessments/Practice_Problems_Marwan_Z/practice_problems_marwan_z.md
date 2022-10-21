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

On the last line, the class method `method_b` is invoked on the class `Foo` with an argument `Foo`. Upon the invocation of `method_b`, Ruby resolves `Foo.exclamate` to `' for all!!!'` by the same token as stated above. Hence, `Foo.method_b(Foo)` returns `"Justice for all!!!"` which is then outputted to the console.

## 6

Will the following code execute? What will be the output?

````ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
     "Hello! they call me #{name}"
  end
end

class Puppet < Person
  def initialize(name)
    super
  end

  def greet(message)
    puts super + message
  end
end

puppet = Puppet.new("Cookie Monster")
puppet.greet(" and I love cookies!")
````

The above code will raise `ArgumentError`.

On the last line, the `greet` method is invoked on the `Puppet` object referenced by `puppet` with an argument `" and I love cookies"`. Upon the method invocation of `Puppet#greet`, the `super` keyword invokes the method of the same name in the superclass, which is `Person#greet`, and passes the argument that is passed to `Puppet#greet` to `Person#greet`. However, as `Person#greet` does not accept any argument, it raises `ArgumentError`.

## 7

What concept does this code demonstrate? What will be the output?

````ruby
class Bird
  def fly
    p "#{self.class} is flying!"
  end
end

class Pigeon < Bird; end
class Duck < Bird; end

birds = [Bird.new, Pigeon.new, Duck.new].each(&:fly)
````

The above code will output the following to the console:

````text
"Bird is flying!"
"Pigeon is flying"
"Duck is flying!"
````

The above code demonstrates the concept of polymorphism through inheritance. Polymorphism means objects of different types respond to the same method invocation.

In the above code, a `Bird` class with an instance method `fly` is defined. Two subclasses of `Bird`, namely `Pigeon` and `Duck`, are then defined. Both subclasses inherit the `fly` method from their superclass `Bird`. Therefore, when we iterate an array containing a `Bird`, a `Pigeon` and a `Duck` object and invoke the `fly` on each of them, they all can respond to it, albeit differently.

## 8

What does the `self` keyword refer to in the `good` method?

````ruby
class Dog
  attr_accessor :name

  def good
    self.name + " is a good dog"
  end
end

bandit = Dog.new
bandit.name = "Bandit"
p bandit.good
````

The `self` keyword in the `good` method refers to the calling object of the `good` method, because that `self` keyword is in an instance method.

## 9

What will the last three lines of code print to the console? After `song.artist` is called, what would be returned if we inspect the `Song` object referenced by `song`?

````ruby
class Song                            # 1
  attr_reader :title, :artist         # 2
                                      # 3
  def initialize(title)               # 4
    @title = title                    # 5
    @artist                           # 6
  end                                 # 7
                                      # 8
  def artist=(name)                   # 9
    @artist = name.upcase             # 10
  end                                 # 11
end                                   # 12
                                      # 13
p song = Song.new("Superstition")     # 14
p song.artist = "Stevie Wonder"       # 15
p song.artist                         # 16
````

On line 14, a new `Song` object is instantiated. The `new` class method invoked on the `Song` class with an argument `"Superstition"` triggers the invocation of `Song#initialize`. Upon the invocation, the instance variable `@title` is initialized to `"Superstition"` and `@artist` remains uninitialized. Therefore, `song = Song.new("Superstition")` returns a `Song` object with an attribute `@title = "Superstition"`. When it is outputted to the console by the `p` method, it outputs to the console the class of the object, the encoding of the object ID, and the only attribute `@title = "Superstition"`.

On line 15, the setter method of `@artist` is called on `song` which assigns the string `"Stevie Wonder"` to the instance variable `@artist`. At this point, the `Song` object referenced by `song` has two attributes: `@title = "Superstition"` and `@artist = "STEVIE WONDER"`. As a setter always returns the value passed in as an argument, `song.artist = "Stevie Wonder"` returns `"Stevie Wonder"`, and hence it is outputted to the console by the `p` method.

On line 16, the getter method of `@artist` is called on `song` which returns the value referenced by `@artist`. As `@artist` points to the string `"STEVIE WONDER"`, it is outputted to the console by the `p` method.

## 10

What will the last 2 lines output in this case?

````ruby
class Song                          # 1
  attr_reader :title, :artist       # 2
                                    # 3
  def initialize(title)             # 4
    @title = title                  # 5
  end                               # 6
                                    # 7
  def artist=(name)                 # 8
    @artist = name                  # 9
    name.upcase!                    # 10
  end                               # 11
end                                 # 12
                                    # 13
song = Song.new("Superstition")     # 14
p song.artist = "Stevie Wonder"     # 15
p song.artist                       # 16
````

On line 14, a new `Song` object is instantiated with an attribute `@title = "Superstition"` and is assigned to the local variable `song`.

On line 15, the setter method of `artist` is invoked on `song`. The instance variable `@artist` is asssigned to the value that `name` is referencing, which is `"Stevie Wonder"`. At this point, both `@artist` and `name` point to the same string `"Stevie Wonder"`. The destructive method `upcase!` is then called on `name` which mutates the string to `"STEVIE WONDER"`. This change also refects in `@artist` which points to `"STEVIE WONDER"`. For a setter method, it always returns the argument passed in as an argment. However, the argument is modified in place to `"STEVIE WONDER"`. Therefore, `song.artist = "Stevie Wonder"` returns `"STEVIE WONDER"`, which is then outputted to the console by the `p` method.

On line 16, the getter method of `@artist` is called on `song` which returns the value referenced by `@artist`. As `@artist` points to the string `"STEVIE WONDER"`, it is outputted to the console by the `p` method.
