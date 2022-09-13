# Lecture Problems

## Reading OO Code

## Classes and Objects, Encapsulation, Collaborator Objects and Public/Private/Protected Methods

### 1

If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

````ruby
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
````

We can do so by `bob.name == rob.name`.

### 2

Create an empty class named Cat.

````ruby
class Cat; end
````

### 3

Using the code from the previous exercise, create an instance of `Cat` and assign it to a variable named `kitty`.

````ruby
kitty = Cat.new
````

### 4

Identify all custom-defined objects that act as collaborator objects within the code.

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

The only custom-defined object that act as a collaborator object is the `Person` object referenced by `sara`.

Technically, `"Sara"` and `"Fluffy"` are also collaborator objects, but they are not custom-defined.

### 5

````ruby
class Pet                      # 1
  attr_reader :name            # 2
                               # 3
  def initialize(name)         # 4
    @name = name.to_s          # 5
  end                          # 6
                               # 7
  def to_s                     # 8
    @name.upcase!              # 9
    "My name is #{@name}."     # 10
  end                          # 11
end                            # 12
                               # 13
name = "Fluffy"                # 14
fluffy = Pet.new(name)         # 15
puts fluffy.name               # 16
puts fluffy                    # 17
puts fluffy.name               # 18
puts name                      # 19
````

On line 14, the local variable `name` is assigned to the string `"Fluffy"`.

On line 15, a new `Pet` object is instantiated with an attribute `@name = "Fluffy"` and assigned to the local variable `fluffy`. At this point, both the local variable `name` and the instance variable `@name` reference the same string `"Fluffy"`.

When we invoke the getter of `@name` on `fluffy`, it returns `"Fluffy"`. Hence the line 16 outputs `Fluffy` to the console.

On line 17, when we invoke `puts` with the argument `fluffy`, it outputs the string representation of the `Pet` object that `fluffy` references to the console. In other words, the `to_s` method is automatically invoked on `fluffy` and the return value is outputted. Upon the invocation of `to_s`, `@name` is modified in place to `"FLUFFY"`. Therefore `fluffy.to_s` returns `"My name is FLUFFY."`, which is what is printed to the console by line 17.

As the value that `@name` references is mutated to `"FLUFFY"`, when we invoke the getter of `@name` on `fluffy`, it returns `"FLUFFY"` and is printed to the console by line 18.

As both the local variable `name` and the instance variable `@name` reference the same string and `@name` is now mutated to `"FLUFFY"`, `name` reference `"FLUFFY"` as well. Hence the line 19 prints `FLUFFY` to the console.

### 6

````ruby
class Pet                          # 1
  attr_reader :name                # 2
                                   # 3
  def initialize(name)             # 4
    @name = name.to_s              # 5
  end                              # 6
                                   # 7
  def to_s                         # 8
    @new_name = @name.upcase       # 9
    "My name is #{@new_name}."     # 10
  end                              # 11
end                                # 12
                                   # 13
name = 42                          # 14
fluffy = Pet.new(name)             # 15
name += 1                          # 16
puts fluffy.name                   # 17
puts fluffy                        # 18
puts fluffy.name                   # 19
puts name                          # 20
````

On line 14, the local variable `name` is assigned to the integer `42`.

On line 15, a new `Pet` object is instantiated with an attribute `@name = "42"` and assigned to the local variable `fluffy`. At this point, both the local variable `name` and the instance variable `@name` reference different objects, which are respectively `42` and `"42"`.

On line 16, `name` is incremented by `1` and hence references a new integer `43`. This does not affect the value that `@name` references as integers are immutable.

Therefore, when we call the getter of `@name` on fluffy, it returns the string `"42"` which is then outputted to the console.

On line 18, it outputs the string representation of the `Pet` object that `fluffy` references to the console. To do that, `to_s` is automatically invoked on `fluffy`, and the return value is printed to the console. Upon the invocation of `to_s` on `fluffy`, a new instance variable `@new_name` is initialized to the string `"42"`, and hence it returns `"My name is 42."`, which is then outputted to the console.

At this point, the instance variable `@name` is unaltered and still references `"42"`. Therefore, when we call the getter of `@name` on `fluffy` on line 19, it returns `"42"` and is outputted to the console.

At this point, the local variable `name` points to the integer `43`. Therefore, line 20 outputs `43` to the console.

## Polymorphism, Inheritance, Modules and Method Lookup Path

### 1

What will line 17 output, and why?

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
p bruno.name                     # 17
````

The line 17 returns `"brown"` and outputs `"brown"` to the console.

On line 16, a new `GoodDog` object is instantiated and assigned to the local variable `bruno`.

Upon instantiation, the constructor `GoodDog#initialize` is invoked with an argument `"brown"`. When `super` is invoked on line 11, it **forwards** all arguments that are passed to `GoodDog#initialize` to `Animal#initialize` and invokes it, which creates the attribute `@name = "brown"`.

Therefore, when we call the getter of the instance variable `@name` on the `GoodDog` object that `bruno` references, it returns `"brown"`, and hence line 17 outputs `"brown"` to the console.

## `attr_*`, Getters and Setters, and Referencing and Setting Instance Variables

### 5

Given the below usage of the `Person` class, code the class definition.

````ruby
bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'
````

````ruby
class Person(name)
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end
````

### 6

Modify the class definition from above to facilitate the following methods. Note that there is no `name=` setter method now.

````ruby
bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'
````

````ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    @name = name
    
    name_parts = @name.split
    if name_parts.size == 1
      @first_name, @last_name = name_parts.first, ' '
    elsif name_parts.size == 2
      @first_name, @last_name = name_parts.first, name_parts.last
    end
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
end
````

### 7

Now create a smart `name= method that can take just a first name or a full name, and knows how to set the `first_name` and `last_name` appropriately.

````ruby
bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'
````

````ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    self.name = name
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(name)
    name_parts = name.split
    @first_name = name_parts.first
    @last_name = name_parts.size > 1 ? name_parts.last : ' '
  end
end
````

## Instance/Class Methods, `self` and `to_s`

### 2

Given the `Person` class definition below, what does the below print out?

````ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    self.name = name
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(name)
    name_parts = name.split
    @first_name = name_parts.first
    @last_name = name_parts.size > 1 ? name_parts.last : ' '
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
````

The output is `The person's name is #<Person:0x0000000001e8e878>`.

### 3

Let's add a `to_s` method to the above `Person` class:

````ruby
class Person
  # ... rest of class omitted for brevity

  def to_s
    name
  end
end
````

Now, what does the below output?

````ruby
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
````

The output is `The person's name is Robert Smith`.
