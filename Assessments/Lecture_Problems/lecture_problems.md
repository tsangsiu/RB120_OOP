# Lecture Problems

## Reading OO Code

## Classes and Objects, Encapsulation, Collaborator Objects, Public/Private/Protected Methods

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
