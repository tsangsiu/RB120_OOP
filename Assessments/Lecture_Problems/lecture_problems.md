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

What will the following code output?

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

The above code outputs `"Daisy says moooooooooooo!"` to the console.

On line 21, a new `Cow` object with an attribute `@name = 'Daisy'` is instantiated and assigned to the local variable `daisy`.

On line 22, the `speak` method is invoked on the `Cow` object that `daisy` references. As the `Cow` class does not have the `speak` method defined, Ruby looks for it in the next class according to the method lookup path of the class `Cow`, which is `Animal`, and invokes it.

Upon the invocation of `Animal#speak`, the statement `puts sound` is executed. Ruby first looks for the local variable `sound`, which is not available. Ruby then looks for the method `sound`. Ruby looks for it according to the method lookup path again (which is `[Cow, Animal, Object, Kernel, BasicObject]`). It finds it in the `Cow` class and invokes it.

Upon the invocation of `Cow#sound`, the statement `super + "moooooooooooo!"` is executed. The `super` keyword triggers the invocation of the method with the same name one level up in the hierarchy, which is the `Animal#speak` method which returns `"Daisy says "`. Therefore the invocation of `Cow#sound` returns the string `"Daisy says moooooooooooo!"` and thus `daisy.speak` outputs `"Daisy says moooooooooooo!"` to the console.

### 2

### 3

What change(s) do you need to make to the code below in order to get the expected output?

````ruby
class Character                                       # 1
  attr_accessor :name                                 # 2
                                                      # 3
  def initialize(name)                                # 4
    @name = name                                      # 5
  end                                                 # 6
                                                      # 7
  def speak                                           # 8
    "#{@name} is speaking."                           # 9
  end                                                 # 10
end                                                   # 11
                                                      # 12
class Knight < Character                              # 13
  def name                                            # 14
    "Sir " + super                                    # 15
  end                                                 # 16
end                                                   # 17
                                                      # 18
sir_gallant = Knight.new("Gallant")                   # 19
sir_gallant.name # => "Sir Gallant"                   # 20
sir_gallant.speak # => "Sir Gallant is speaking."     # 21
````

**First Attempt**

The output by line 21 is unexpected.

In order to get the expected output, we should change line 9 to `"#{name} is speaking".`.

On line 19, a new `Knight` object with an attribute `@name = "Gallant"` is instantiated and assigned to the local variable `sir_gallant`.

On line 21, the `speak` method is called on the `Knight` object that `sir_gallant` references. As there is no `speak` method defined in the `Knight` class, Ruby looks for the method in the next class up in the hierarchy, which is `Character`. Ruby finds `Character#speak` and invokes it.

Upon the invocation of `Character#speak`, it returns the string `"Gallant is speaking."`. Instead of the string referenced by `@name` (`"Gallant"`), we want the return value of `Knight#name` (`"Sir Gallant"`), so we should change `@name` to `name` on line 9.

**Second Attempt**

On line 19, a new `Knight` object is instantiated with an argument `"Gallant"`. As `Knight` is a subclass of `Character` and the `Knight` class does not have the `initialize` method defined, `Character#initialize` is invoked upon instantiation, which then gives us a `Knight` object with an attribute `@name = "Gallant"`. The object is then assigned to the local variable `sir_gallant`.

When the `speak` method is invoked on `sir_gallant` on line 21, the `Character#speak` method is invoked and returns `"Gallant is speaking"`. However, we want `"Sir Gallant is speaking"`. To get the expected output, we can simply replace the instance variable reference `@name` on line 9 to `name`, where `name` here refers to the `Knight#name` method, which overrides `Character#name` and returns `Sir Gallant`.

### 4

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

### 5

Make necessary changes to the below code so as to return the expected values.

````ruby
class FarmAnimal                                  # 1
  def speak                                       # 2
    "#{self} says "                               # 3
  end                                             # 4
end                                               # 5
                                                  # 6
class Sheep < FarmAnimal                          # 7
  def speak                                       # 8
    super + "baa!"                                # 9
  end                                             # 10
end                                               # 11
                                                  # 12
class Lamb < Sheep                                # 13
  def speak                                       # 14
    "baaaaaaa!"                                   # 15
  end                                             # 16
end                                               # 17
                                                  # 18
class Cow                                         # 19
  def speak                                       # 20
    super + "mooooooo!"                           # 21
  end                                             # 22
end                                               # 23
                                                  # 24
Sheep.new.speak # => "Sheep says baa!"            # 25
Lamb.new.speak # => "Lamb says baa!baaaaaaa!"     # 26
Cow.new.speak # => "Cow says mooooooo!"           # 27
````

Line 3 should change to `"#{self.class} says "`.

Line 15 should change to `super + "baaaaaaa!"`.

Line 19 should change to `class Cow < FarmAnimal`.

### 6

What is the return value of the last line, and why?

````ruby
class Person         # 1
  def get_name       # 2
    @name            # 3
  end                # 4
end                  # 5
                     # 6
bob = Person.new     # 7
bob.get_name         # 8
````

On line 7, a new `Person` object is instantiated and assigned to the local variable `bob`.

When we invoke the `get_name` method on `bob`, it returns `@name`. As the instance variable `@name` is never initialized to any value. Ruby treats it as if it points to `nil`. Therefore the last line returns `nil`.

### 7

How do you get this code to return `"swimming"`? What does this demonstrate about instance variables?

````ruby
module Swim                      # 1
  def enable_swimming            # 2
    @can_swim = true             # 3
  end                            # 4
end                              # 5
                                 # 6
class Dog                        # 7
  include Swim                   # 8
                                 # 9
  def swim                       # 10
    "swimming!" if @can_swim     # 11
  end                            # 12
end                              # 13
                                 # 14
teddy = Dog.new                  # 15
teddy.swim                       # 16                        
````

On line 16, the `swim` method is invoked on the `Dog` object that `teddy` references.

Upon the invocation of `Dog#swim`, it returns `"swimming"` if the value referenced by `@can_swim` is truthy. However, at this point, the instance variable `@can_swim` is never initialized to any value. By default, Ruby treats any uninitialized instance variables as if they point to `nil`, which is falsy.

In order to get the above code to return `"swimming"`, we should first initialize `@can_swim` to `true`. Invoking the `Dog#enable_swimming` method can do the job.

Therefore, before line 16, we should first execute the statement `teddy.enable_swimming`.

### 8

What would the below code return? Why?

````ruby
class Vehicle                     # 1
  @@wheels = 4                    # 2
                                  # 3
  def self.wheels                 # 4
    @@wheels                      # 5
  end                             # 6
end                               # 7
                                  # 8
Vehicle.wheels        # => ??     # 9
                                  # 10
class Motorcycle < Vehicle        # 11
  @@wheels = 2                    # 12
end                               # 13
                                  # 14
Motorcycle.wheels     # => ??     # 15
Vehicle.wheels        # => ??     # 16
                                  # 17
class Car < Vehicle               # 18
end                               # 19
                                  # 20
Car.wheels            # => ??     # 21
````

On line 9, the class method `wheels` returns the class variable `@@wheels`, which is `4`.

On lines 11 to 13, a subclass of `Vehicle` called `Motorcycle` is defined. Inside the class `Motorcycle`, a class variable `@@wheels` is defined. As a class and all its subclasses share only one copy of the class variable, this overrides the class variable in `Vehicle`. Therefore, lines 15 and 16 both return `2`.

On lines 18 to 19, another subclass of `Vehicle` called `Car` is defined. The `Car` class also shares a copy of the class variable `@@wheels`, which at this point points to `2`. Therefore, line 21 returns `2`.

### 9

Describe the error and provide two different ways to fix it.

````ruby
module Maintenance                  # 1
  def change_tires                  # 2
    "Changing #{WHEELS} tires."     # 3
  end                               # 4
end                                 # 5
                                    # 6
class Vehicle                       # 7
  WHEELS = 4                        # 8
end                                 # 9
                                    # 10
class Car < Vehicle                 # 11
  include Maintenance               # 12
end                                 # 13
                                    # 14
a_car = Car.new                     # 15
a_car.change_tires                  # 16
````

Upon the invocation of `change_tires` on the `Car` object referenced by `a_car`, Ruby tries to resolve the constant reference `WHEELS`. It first searches the constant lexically, i.e., the enclosing structure of the constant reference. The constant is not found, and thus line 16 will throw `NameError`.

Ruby first searches the constant lexically. If the constant is not found, it searches up the inheritance hierarchy from where the constant is referenced. And finally, the main scope.

Therefore, in this case, there is no inheritance hierarchy from where the constant is referenced (line 3) To resolve the issue, we can either define the constant `WHEEL` in the module `Maintenance` or in the main scope:

````ruby
module Maintenance
  WHEELS = 4

  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
a_car.change_tires # => 4
````

````ruby
module Maintenance
  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

WHEELS = 4

a_car = Car.new
a_car.change_tires # => 4
````

### 10

Using the following code, allow `Truck` to accept a second argument upon instantiation. Name the parameter `bed_type` and implement the modification so that `Car` continues to only accept one argument.

````ruby
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type
````

````ruby
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  attr_reader :bed_type

  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type
````

### 11

Given the following code, modify `start_engine` in `Truck` by appending `'Drive fast, please!'` to the return value of `start_engine` in Vehicle. The `'fast'` in `'Drive fast, please!'`` should be the value of `speed`.

````ruby
class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')
````

````ruby
class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast') # => "Ready to go! Drive fast, please!"
````

### 12

When we call the `go_fast` method on an instance of the `Car` class (as shown below), you might have noticed that the string printed includes the name of the type of vehicle we are using. How is this be done?

````ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
````

The `Speed` module is mixed into the `Car` class, so the `go_fast` method is available to the `Car` class as an instance method.

Inside the `Car#go_fast` method, `self` refers to the calling object. Therefore `self.class` would return `Car`.

That's why the string printed includes the name of the vehicle type on which the `go_fast` method is invoked.

### 13

What will this return? Why?

````ruby
module Drivable
  def self.drive
    "is this possible"
  end
end

class Car
  include Drivable
end

p Car.drive
````

The above code will raise `NoMethodError`.

Inside the module definition of `Drivable`, the method `drive` is defined with a prefix `self.`. The `drive` method will become a module method, which can only be called by `Drivable::drive` or `Drivable.drive`. Therefore, `Car.drive` will raise `NoMethodError`.

### 14

Note: Not sure what the question is.

````ruby
module EmailFormatter
  def email
    "#{first_name}.#{last_name}@#{domain}"
  end
end

module EmailSender
  def email(msg, sender, recipient)
    # contrived implementation for now
    puts "Delivering email to #{recipient} from #{sender} with message: #{msg}"
  end
end

class User
  attr_accessor :first_name, :last_name, :domain
  include EmailFormatter
  include EmailSender
end

u = User.new
u.first_name = "John"
u.last_name = "Smith"
u.domain = "example.com"

p u.email
````

## `attr_*`, Getters and Setters, and Referencing and Setting Instance Variables

### 1

Why does the `change_info` method not work as expected here?

````ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info # => Sparky weighs 10 lbs and is 12 inches tall.
````

In the above code, its intention is to change the attributes of the `GoodDog` object referenced by `sparky` by calling the setters in the `change_info` method.

However, the setters are invoked without the explicit caller `self.`. Ruby will regard that as local variable initialization. To disambiguate from that, the `change_info` should be defined like this :

````ruby
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
````

### 2

What code snippet can replace the "omitted code" comment to produce the indicated result?

````ruby
class Person
  attr_writer :first_name, :last_name

  def full_name
    # omitted code
  end
end

mike = Person.new
mike.first_name = 'Michael'
mike.last_name = 'Garcia'
mike.full_name # => 'Michael Garcia'
````

`"#{@first_name} #{@last_name}"`

### 3

The last line in the below code should return `"A"``. Which method(s) can we add to the Student class so the code works as expected?

````ruby
class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
priya.grade # => "A"
````

We can add the following method to the `Student` class:

````ruby
def change_grade(grade)
  self.grade = grade
end
````

### 4

Following the above question, why would the following not work?

````ruby
def change_grade(new_grade)
  grade = new_grade
end
````

The intention of the `change_grade` method is to change the value referenced by the instance variable `@grade` by calling its setter. However, the setter `#grade` does not prepended with `self.`. Ruby will regards it as local variable initialization. That's why the above method does not work.

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

Now create a smart `name=` method that can take just a first name or a full name, and knows how to set the `first_name` and `last_name` appropriately.

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

### 8

What will the following code output? Why?

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

The above code will output `"bark! bark!  bark! bark!"` to the console.

On line 15, a new `Dog` object is instantiated. This triggers the invocation of `Dog#initialize`, which takes the argument `name = "Teddy"`. Nothing is done in this constructor. At this point, the instance variable `@name` is not initialized, and thus Ruby treats it as if it points to `nil`.

Therefore, when we call the `dog_name` method on `teddy`, it returns `"bark! bark!  bark! bark!"`, which is what is printed to the console.

### 9

What is wrong with the following code? Why? What principle about getter/setter methods does this demonstrate?

````ruby
class Cat                     # 1
  attr_accessor :name         # 2
                              # 3
  def initialize(name)        # 4
    @name = name              # 5
  end                         # 6
                              # 7
  def rename(new_name)        # 8
    name = new_name           # 9
  end                         # 10
end                           # 11
                              # 12
kitty = Cat.new('Sophie')     # 13
p kitty.name # "Sophie"       # 14
kitty.rename('Chloe')         # 15
p kitty.name # "Chloe"        # 16
````

The `rename` method in the `Cat` class is problematic.

The intention of the `Cat#rename` method is to change the name attribute of a `Cat` object by calling the setter method of the instance variable `@name`. However, inside the `rename` method, the setter method `name` is invoked without an explicit caller `self`. Ruby will regard that as local variable initialzation. The name attribute of a `Cat` object therefore remains unchanged after invoking the `rename` method. That's why line 16 outputs an unexpected result.

In principle, if we want to invoke a setter method inside an instance method, the setter method should be prepended with `self.`.

### 10

You can see in the `make_one_year_older` method we have used `self`. What does self refer to here?

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

Inside an instance method, `self` refers to the calling object.

## Instance/Class Methods, `self` and `to_s`

### 1

On which lines in the following code does `self` refer to the instance of the `MeMyselfAndI` class referenced by `i` rather than the class itself? Select all that apply.

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

On lines 5 and 9, the `self` refers to the `MeMyselfAndI` object referenced by `i`.

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

### 4

Why does the code below do not have the expected return value?

````ruby
class Student                                                        # 1
  attr_accessor :grade                                               # 2
                                                                     # 3
  def initialize(name, grade = nil)                                  # 4
    @name = name                                                     # 5
  end                                                                # 6
end                                                                  # 7
                                                                     # 8
ade = Student.new('Adewale')                                         # 9
ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">     # 10
````

On line 9, a new `Student` object is instantiated and is then assigned to the local variable `ade`.

Upon the instantiation, the method `Student#initialize` is invoked with arguments `name` (which points to the string `Adewale`) and `grade` (which points to the default value `nil`). Upon the invocation of `Student#initialize`, the instance variable `@name` is assigned to `Adewale`, and the instance variable `@grade` is never initialized. Therefore the `Student` object referenced by `ade` only has the attribute `@name = "Adewale"`.

## Fake Operators and Equality

### 1

What will the code below return and why?

````ruby
arr1 = [1, 2, 3]                                 # 1
arr2 = [1, 2, 3]                                 # 2
arr1.object_id == arr2.object_id     # => ??     # 3
                                                 # 4
sym1 = :something                                # 5
sym2 = :something                                # 6
sym1.object_id == sym2.object_id     # => ??     # 7
                                                 # 8
int1 = 5                                         # 9
int2 = 5                                         # 10
int1.object_id == int2.object_id     # => ??     # 11
````

On line 3 we are checking if the object IDs of the objects referenced by `arr1` and `arr2` are the same. As `arr1` and `arr2` point to different arrays, line 3 will return `false`.

In Ruby, symbols and integers with the same value are actually the same object, as they are immutable. This is in fact the performance optimization done by Ruby. Therefore, if we compare the object IDs of two symbols or integers having the same value, they will be identical, and thus lines 7 and 11 will return `true`.

### 2

How can you make the code below function? How is this possible?

````ruby
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)
puts "bob is older than kim" if bob > kim
````

We can make the above code function by defining the following `>` method in the `Person` class:

````ruby
def >(other_person)
  age > other_person.age
end
````

It is possible because `>` in Ruby is in fact a method. We can define our own `>` method to tell Ruby how to compare two `Person` objects. In this case, we compare two `Person` objects' ages.

### 3

What happens here, and why?

````ruby
my_hash = {a: 1, b: 2, c: 3}     # 1
my_hash << {d: 4}                # 2
````

The above code attempts to add a key-value pair to the hash referenced by `my_hash` using the method `<<`. However, as the `<<` method is not defined in the `Hash` class, line 2 throws `NoMethodError`.

### 4

````ruby
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    members + other_team.members
  end
end
````

We use the same `Person` class from earlier.

````ruby
cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
dream_team = cowboys + niners
````

What does the `Team#+` method return? What is the problem with this? How could you fix this problem?

The `Team#+` method returns a new `Array` object.

There is a consistency problem with this here. For the Ruby standard library, `String#+` returns a new `String` object, `Array#+` returns a new `Array` object, and `Integer#+` returns a new `Integer` object. Following the pattern, we would expect that `Team#+` would retrurn a new `Team` object.

To fix the problem, we could redefine the `Team#+` method like this:

````ruby
def +(other_team)
  temp_team = Team.new('Temporary Team')
  temp_team.members = members + other_team.members
  temp_team
end
````
