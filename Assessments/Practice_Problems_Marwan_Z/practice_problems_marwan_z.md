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

## 11

What would `cat.name` return after the last line of code is executed?

````ruby
class Cat                 # 1
  attr_accessor :name     # 2
                          # 3
  def set_name            # 4
    name = "Cheetos"      # 5
  end                     # 6
end                       # 7
                          # 8
cat = Cat.new             # 9
cat.set_name              # 10
````

On line 9, a new `Cat` object is instantiated and assigned to the local variable `cat`.

On line 10, the `set_name` method is called on `cat`. Upon the method invocation, the local variable `name` is assigned to the string `"Cheetos"`. The instance variable `@name` remains uninitialized.

Therefore, when we invoke the getter method of `@name` on `cat` (`cat.name`), it returns `nil`.

## 12

What will the last two lines of code output?

````ruby
module Walk
  STR = "Walking"
end

module Run
  STR = "Running"
end

module Jump
  STR = "Jumping"
end

class Bunny
  include Jump
  include Walk
  include Run
end

class Bugs < Bunny; end

p Bugs.ancestors
p Bugs::STR
````

The second last line will output `[Bugs, Bunny, Run, Walk, Jump, Object, Kernel, BasicObject]` to the console.

The last line will output `"Running"` to the console.

## 13

What will be returned by the `value1` and `value2` method calls?

````ruby
VAL = 'Global'            # 1
                          # 2
module Foo                # 3
  VAL = 'Local'           # 4
                          # 5
  class Bar               # 6
    def value1            # 7
      VAL                 # 8
    end                   # 9
  end                     # 10
end                       # 11
                          # 12
class Foo::Bar            # 13
  def value2              # 14
    VAL                   # 15
  end                     # 16
end                       # 17
                          # 18
p Foo::Bar.new.value1     # 19
p Foo::Bar.new.value2     # 20
````

On line 19, the `value1` method is invoked on a `Foo::Bar` object and returns the constant referenced by `VAL`. To resolve the constant, Ruby first looks for it in the lexical scope, i.e., the enclosing structure of where the constant is referenced which is on line 8. Ruby then finds the constant on line 4. The constant `VAL` is then resolved to `'Local'`, and is outputted to the console by the method `p`.

On line 20, the `value2` method is invoked on another `Foo::Bar` object and returns the constant referenced by `VAL` (line 15). Ruby cannot find the constant in the lexical scope. Ruby then looks for the constant up in the method lookup path from where it is referenced. As there is no inheritance involved, Ruby at last looks for the constant in the main scope on line 1. The constant `VAL` is resolved to `'Glibal'`, and is outputted to the console by the method `p`.

## 14

Write 3 methods inside the `Person` class that would return the outputs shown on lines 23 and 24.

````ruby
class Person                             # 1
  attr_reader :friends                   # 2
                                         # 3
  def initialize                         # 4
    @friends = []                        # 5
  end                                    # 6
end                                      # 7
                                         # 8
class Friend                             # 9
  attr_reader :name                      # 10
                                         # 11
  def initialize(name)                   # 12
    @name = name                         # 13
  end                                    # 14
end                                      # 15
                                         # 16
tom = Person.new                         # 17
john = Friend.new('John')                # 18
amber = Friend.new('Amber')              # 19
                                         # 20
tom << amber                             # 21
tom[1] = john                            # 22
p tom[0]      # => Amber                 # 23
p tom.friends # => ["Amber", "John"]     # 24
````

````ruby
class Person
  attr_reader :friends

  def initialize
    @friends = []
  end
  
  def <<(friend)
    friends << friend.name
  end
  
  def []=(index, friend)
    friends[index] = friend.name
  end
  
  def [](index)
    friends[index]
  end
end

class Friend
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

tom = Person.new
john = Friend.new('John')
amber = Friend.new('Amber')

tom << amber
tom[1] = john
p tom[0]      # => Amber
p tom.friends # => ["Amber", "John"]
````

## 15

What will be output when the last 2 lines of code get executed?

````ruby
class Foo           # 1
  @@var = 1         # 2
                    # 3
  def self.var      # 4
    @@var           # 5
  end               # 6
end                 # 7
                    # 8
class Bar < Foo     # 9
  @@var = 2         # 10
end                 # 11
                    # 12
puts Foo.var        # 13
puts Bar.var        # 14
````

On lines 1 to 7, a class named `Foo` is defined with a class variable `@@var = 1`.

On lines 9 to 11, a class named `Bar` which inherits the class `Foo` is defined with a class variable `@@var = 2`.

As a superclass and its subclasses share only one copy of the class variable, both class variables `@@var` in the classes `Foo` and `Bar` both point to `2`. Therefore, when we invoke the class method `var` on `Foo` and `Bar`, they both return `2` and are ouputted to the console by the `puts` method.

## 16

Update the `Human` class to have lines 9 and 12 return the desired output.

````ruby
class Human                                                     # 1
    attr_reader :name                                           # 2
                                                                # 3
  def initialize(name="Dylan")                                  # 4
    @name = name                                                # 5
  end                                                           # 6
end                                                             # 7
                                                                # 8
puts Human.new("Jo").hair_color("blonde")                       # 9
# Should output "Hi, my name is Jo and I have blonde hair."     # 10
                                                                # 11
puts Human.hair_color("")                                       # 12
# Should "Hi, my name is Dylan and I have blonde hair."         # 13
````

````ruby
class Human 
  attr_reader :name

  def initialize(name = "Dylan")
    @name = name
  end

  def hair_color(hair_color)
    @hair_color = hair_color
    self
  end

  def to_s
    "Hi, my name is #{@name} and I have #{@hair_color} hair."
  end

  def self.hair_color(hair_color)
    hair_color = "blonde" if hair_color == ""
    "Hi, my name is #{self.new.name} and I have #{hair_color} hair."
  end
end

puts Human.new("Jo").hair_color("blonde")  
# Should output "Hi, my name is Jo and I have blonde hair."

puts Human.hair_color("")
# Should "Hi, my name is Dylan and I have blonde hair."
````
