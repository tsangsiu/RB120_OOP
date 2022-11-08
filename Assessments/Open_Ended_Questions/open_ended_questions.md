# Open-Ended Questions

## Reading OO Code

### What is OOP and why is it important?

Object-oriented programming (OOP) is a programming paradigm that makes use of objects and their interaction to design computer programs.

It is important because of the following points:

- Large, complex programs can be difficult to maintain due to dependencies throughout the program. OOP lets programmers write programs in which different parts of the program interact, thus reducing dependencies and facilitating maintenance.
- Coding in a non-OO way often means writing code that is useful solely within a single context. Defining basic classes and leveraging concepts like inheitance to introduce more detailed behaviors provides a greater level of reusability and flexibility.
- Complex coding problems are often difficult to break down an solve in a clear and systematic way. Using OOP to model classes appropriate to the problem, and using real-world nouns to represent objects, lets programmers think at a higher level of abstraction that helps them break down and solve problems.

### What is a spike?

A spike is an initial exploratory code to play around with a problem. It can help validate our initial hypotheses.

### When writing a program, what is a sign that you’re missing a class?

Repetitive nouns in a method is the sign.

### What are some rules/guidelines when writing programs in OOP?

[Guidelines](https://launchschool.com/lessons/dfff5f6b/assignments/d632a90f)

## Classes and Objects, Encapsulation, Collaborator Objects and Public/Private/Protected Methods

### What is encapsulation? How does encapsulation relate to the public interface of a class?

Encapsulation means restricting access to an object's data (attributes and behaviors), and exposing only behaviors that users of the object need.

One of the advantages of encapsulation is that it allows the hiding of complex implementation, and thus allows programmer to think at a new level of abstraction.

Let's say we are building a game involving a player and an enemy, and the enemy has the ability to speak. Refer to the class definition of `Enemy` below, we have a public method `speak` defined. This is a public interface of the `Enemy` class. Everytime when a programmer wants the enemy to speak, he or she can simply invoke the `Enemy#speak` method, and the message `"I'm an ememy. You better run!"` is outputted to the console. 

Here, we hide the way how the message is produced by making the `message` method private. In OOP terminology, the `message` method is *encapsulated* in an `Enemy` object. This allows programmers to think on a new level of abstraction. It is because what they care is that a message is outputted to the console when the `Enemy#speak` method is invoked. They do not care how the message is produced or outputted to the console. Here, the implementation of `message` could be `"I'm an enemy." + " " + "You better run!"`, but this is not what programmers concern.

````ruby
class Enemy
  def speak
    puts message
  end
  
  private
  
  def message
    "I'm an enemy. You better run!"
  end
end

enemy = Enemy.new
enemy.speak # => I'm an enemy. You better run!
````

Encapsulation allows programmers to expose methods that users of an object need by making those methods public. Those public methods are the public interfaces of the object. It also allows programmers to hide the implementation details by making the implementation-related methods private.

### What is an object? How do you initialize a new object/How do you create an instance of a class? What is instantiation? What is a constructor method? What is an instance variable, and how is it related to an object? What is an instance method? What is the scoping rule for instance variables?

An object is an instance of a class which defines what attributes and functionalities an object has.

To initialize a new object, we can invoke the class method `::new` on the class name.

Instantiation is the process of creating an object from a class definition.

A constructor method is the method that is invoked every time when we instantiate a new object. In Ruby, it is the private `#initialize` method.

Instance variables are used to store data inside an object. They are the attributes of an object. All attributes combined defines an object's state.

Instance methods are what an object capable of doing. Public instance methods are the public interfaces of an object. Users can store, extract and manipulate data through these interfaces. Prvate instance methods are usually an object's internal implementation.

The scope for instance variables is at object level. They can be accessed any where inside a class, but not outside of it. They last as long as an object exists.

### How do you see if an object has instance variables?

To see if an object has instance variables, we can either invoke the `instance_variables` method on it, or inspect the string representation of the object.

### What is a class? What is the relationship between a class and an object? How is defining a class different from defining a method?

A class can be thought of a blueprint of an object. It defines what attributes and behaviors an object will have.

A class is a mold or template for objects. It defines the attributes and behaviors of its objects. An object is an instance of the class.

Defining a class is similar to defining a method, with the following difference:

- To define a class, we start with the reserved word `class`, while we start with the reserved word `def` when defining a method.
- To name a class, we use `CamelCase`, while we use `snake_case` when naming a method.

### How do objects encapsulate state?

### What is the difference between classes and objects?

### How can we expose information about the state of the object using instance methods?

By defining an instance method that returns certain instance variables.

### What is a collaborator object and what is its purpose with regards to OOP?

A collaborator object is an object that is stored as a state of another object. A collaborator object is usually a custom object, although objects of built-in types such as strings and arrays are technically collaborator objects.

By creating collaborator objects, objects of different types can work together and build association. In other way, a problem can be broken down into cohesive pieces that work together.

For example, in a library, there is a collection of books. We can consider `Book` objects to be collaborator objects to a `Library` object. It is because `Book` and `Library` are separate objects, and they work meaningfully in a collaborative way. When we need a `Book` object to perform some actions, we can go through a `Library` object and invoke the concerned method on the instance variable which stores the `Book` object or on each `Book` object in a collection.

````ruby
class Library
  attr_accessor :books
  
  def initialize
    @books = []
  end
  
  def <<(book)
    books << book
  end
  
  def display_collection
    books.each { |book| puts book }
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

### What are the two rules of protected methods?

Like private methods, protected methods can only be invoked inside a class. But unlike private methods, they can be invoked on objects of the same kind inside the class.

Take the following code as an example, the getter of the attribute `age` is a protected method. Therefore, when we call it on the `Person` object referenced by `jason` on line 13, it raises `NoMethodError`. The `Person#age` is a protected method and thus it cannot be called outside of the `Person` class like private methods. 

````ruby
class Person                        # 1
  def initialize(name, age)         # 2
    @name = name                    # 3
    @age = age                      # 4
  end                               # 5
                                    # 6
  protected                         # 7
                                    # 8
  attr_reader :age                  # 9
end                                 # 10
                                    # 11
jason = Person.new('Jason', 30)     # 12
p jason.age # => NoMethodError      # 13
````

Let's add a method called `same_age?` to the `Person` class to check if two persons have the same age.

````ruby
class Person                                 # 1
  def initialize(name, age)                  # 2
    @name = name                             # 3
    @age = age                               # 4
  end                                        # 5
                                             # 6
  def same_age?(other_person)                # 7
    age == other_person.age                  # 8
  end                                        # 9
                                             # 10
  protected                                  # 11
                                             # 12
  attr_reader :age                           # 13
end                                          # 14
                                             # 15
jason = Person.new('Jason', 30)              # 16
jack = Person.new('Jack', 30)                # 17
                                             # 18
p jason.same_age?(jack) # => true            # 19
                                             # 20
p jason.same_age?(30) # => NoMethodError     # 21
````

On lines 16 and 17, we instantiate two different `Person` objects. On line 19, the `same_age?` method is invoked on `jason` with the `Person` object referenced by `jack` passed in as an argument. As both `Person` objects have the same age `30`, line 19 returns `true`.

Why is that? Let's consider the implementation of `same_age?`. The `same_age?` method checks if the age of the caller (age given by the value returned by the getter method `age`) is the same as that of the `Person` object passed in to the `same_age?` method (age given by the value returned by `other_person.age`). Here, we assumed that the argument `other_person` passed in to the `same_age?` method would be a `Person` object. Therefore, it is legal to call the protected getter method `age` on the argument `other_person`. As the age of both `Person` objects is the same, line 19 returns `true`.

If the argument passed in to the `same_age?` method is not a `Person` object like on line 21 (and that object does not have a public or protected `age` method), it will raise `NoMethodError`. It is because the protected method `age` can only be called on objects of the same kind (a `Person` object) inside the `same_age?` method.

This illustrates that, unlike private methods, protected methods can be invoked on objects of the same kind inside a class.

## Polymorphism, Inheritance, Modules and Method Lookup Path

### What is polymorphism? How does polymorphism work in relation to public interfaces?

Polymorphism refers to the ability that objects of different types respond to the same method invocation.

In the example below, we define four classes `Human`, `Dog`, `Fish` and `Car`. All classes have the `move` method defined but the implementation is different in each class.

We then create an array containing objects of each class, iterate through it, and invoke the `move` method on each object. In this case, we don't care the type of the objects on which we invoke the `move` method, as long as that object has a compatible `move` method (i.e., a `move` method that takes no argument). Upon the invocation of the `move` method on each object, it prints a message to the console based on the type of the calling object.

This is polymorphism in action. Objects of different types respond to a common method invocation, but in different ways.

````ruby
class Human
  def move
    puts "#{self.class} is walking..."
  end
end

class Dog
  def move
    puts "#{self.class} is running..."
  end
end

class Fish
  def move
    puts "#{self.class} is swimming..."
  end
end

class Car
  def move
    puts "#{self.class} is moving..."
  end
end

my_array = [Human.new, Dog.new, Fish.new, Car.new]
my_array.each do |obj|
  obj.move
end
# => Human is walking...
# => Dog is running...
# => Fish is swimming...
# => Car is moving...
````

For polymorphism to work in the above example, each object type must have a public and compatible `move` method (i.e., a public `move` method that takes no arguments). If any of the object type does not have a public and compatible `move` method, it cannot respond to the `move` method invocation, and thus polymorphism will not work. This is how polymorphism works in relation to public interfaces.

Let's say a `Human` object does not have a public `move` method. It raises `NoMethodError` when the `move` method is invoked on a `Human` object, i.e., a `Human` object does not respond to the method invocation of `move`, and thus polymorphism does not work:

````ruby
class Human
  private

  def move
    puts "#{self.class} is walking..."
  end
end

# other classes omitted for brevity

my_array = [Human.new, Dog.new, Fish.new, Car.new]
my_array.each do |obj|
  obj.move
end
# => NoMethodError
````

Or if a `Human` object does not have a compatible `move` method. It raises `ArgumentError` when the `move` method is invoked on a `Human` object, and thus polymorphism does not work either:

````ruby
class Human
  def move(name)
    puts "#{name} is walking..."
  end
end

# other class omitted for brevity

my_array = [Human.new, Dog.new, Fish.new, Car.new]
my_array.each do |obj|
  obj.move
end
# => ArgumentError
````

### Explain two different ways to implement polymorphism.

### Why should methods in mixin modules be defined without using `self.` in the definition?

Refer to the code below, if a method in a mixin module is defined with `self.` in the definition, it becomes a module method and can only be called by `Swimmable.swim` or `Swimmable::swim`. Furthermore, the method is not available to all instances of the class where the module is mixed in.

```ruby
module Swimmable
  def self.swim; end
end
```

## `attr_*`, Getters and Setters, and Referencing and Setting Instance Variables

### What are accessor methods?

The accessor methods of an instance variable include its getter and setter.

We can have the accessor methods by writing our own getter and setter or by invoking the `attr_accessor` method.

### What is a getter method?

A getter method is a method that returns the value referenced by an object's instance variable. The value outputted could be modified by the getter method.

By default, an object's attributes are not accessible outside of it thanks to encapsulation. If we want to access them, we need to define a getter method.

Take the following code as an example, a `Person` object with an attribute `@name = 'Jason'` is instantiated. However, we cannot access the attribute unless a getter is defined.

````ruby
class Person
  def initialize(n)
    @name = n
  end
end

jason = Person.new('Jason')
p @name # => nil
````

When we have a getter method of the attribute `@name`, the attribute can then be accessed outside the object. In the following example, the getter method is provided by the method `attr_reader` on line 2:

````ruby
class Person                    # 1
  attr_reader :name             # 2
                                # 3
  def initialize(n)             # 4
    @name = n                   # 5
  end                           # 6
end                             # 7
                                # 8
jason = Person.new('Jason')     # 9
p jason.name # => "Jason"       # 10
````

We can also define our own getter, where we can modify the value reference by the instance variable when outputted. In practice, the name of the getter is usually the same as that of the instance variable:

````ruby
class Person
  def initialize(n)
    @name = n
  end

  def name
    @name.capitalize
  end
end

jason = Person.new('jason')
p jason.name # => "Jason"
````

### What is a setter method?

A setter method is a method that allows us to manipulate the value referenced by an object's instance variable.

Thanks to encapsulation, the value referenced by an object's instance variable is not accessible and thus cannot be manipulated outside of the object. If we want to modify it outside of the object, we need a setter method.

The easiest way to get a setter method is by the method invocation of `attr_accessor` or `attr_writer`. The `attr_accessor` method provides us with the getter and setter, while the `attr_writer` method only provides us with the setter method.

In the example below, a `Person` object with an attribute `@name = 'Jayson'` is instantiated. Later when we need to amend the name, we can invoke the setter `Person#name=` provided by the `attr_writer` method on line 2. Thanks to Ruby's syntactical sugar, we can use a more natural syntax `jason.name = 'Jason'` instead of `jason.name=('Jason')`.

````ruby
class Person                                                 # 1
  attr_writer :name                                          # 2
                                                             # 3
  def initialize(name)                                       # 4
    @name = name                                             # 5
  end                                                        # 6
end                                                          # 7
                                                             # 8
jason = Person.new('Jayson')                                 # 9
p jason # => #<Person:0x00000000014cdac8 @name="Jayson">     # 10
                                                             # 11
jason.name = 'Jason'                                         # 12
p jason # => #<Person:0x00000000014cdac8 @name="Jason">      # 13
````

We can also write our own setter method. An advantage is that we can validate or manipulate the value passed in as an argument before assigning to the instance variable.

In the example below, we have our custom setter for the attribute `name` defined. If the argument given is not a string, it won't be assigned to `@name`. If the argument given is a string, it will capitalize the string before assigning to `@name`. This illustrates how a custom setter can validate or manipulate the argument before assigning it to an instance variable.

````ruby
class Person                                                 # 1
  def initialize(name)                                       # 2
    @name = name                                             # 3
  end                                                        # 4
                                                             # 5
  def name=(n)                                               # 6
    @name = n.capitalize if n.class == String                # 7
  end                                                        # 8
end                                                          # 9
                                                             # 10
jason = Person.new('Jayson')                                 # 11
p jason # => #<Person:0x000000000159b810 @name="Jayson">     # 12
                                                             # 13
jason.name = 12345                                           # 14
p jason # => #<Person:0x000000000159b810 @name="Jayson">     # 15
                                                             # 16
jason.name = 'jason'                                         # 17
p jason # => #<Person:0x000000000159b810 @name="Jason">      # 18
````

### What does a setter method return?

Setters always return the value passed in as an argument even when the last evaluated expression is a completely irrelevant string:

````ruby
class Person
  def initialize(name)
    @name = name
  end
  
  def name=(n)
    @name = n
    "This string will not be returned."
  end
end

jason = Person.new('Jayson')
p (jason.name = 'Jason') # => "Jason"
````

### What is `attr_accessor`?

The `attr_accessor` method is a method that accepts symbols representing the names of instance variables. By invoking it, Ruby automatically create the instance variable and its getter and setter.

## Instance/Class Methods, `self` and `to_s`

### Explain what `self` is and how it’s used.

In Ruby, `self` is a reserved keyword that acts as a variable. Depending on where it is referenced in code, `self` can mean different things.

Inside an instance method, `self` references the object that calls the method, as demonstrated by the following example:

````ruby
class Person
  def initialize(n)
    @name = n
  end
  
  def what_is_self
    self
  end
end

jason = Person.new('Jason')
p jason.what_is_self # => #<Person:0x0000000000f2f760 @name="Jason">
````

Similarly, inside a class method, `self` references the class itself. Referring to the code snippet below, the `self` on line 3 inside the class method `Person::what_is_self` refers to the `Person` class, as illustrated on line 7.

````ruby
class Person                          # 1
  def self.what_is_self               # 2
    self                              # 3
  end                                 # 4
end                                   # 5
                                      # 6
p Person.what_is_self # => Person     # 7
````

Elsewhere outside an instance or a class method, `self` references the enclosing structure. Referring back to the code snippet above, the `self` on line 2 references the enclosing structure, which is the `Person` class.

Let's look at one more example below. The `self` on line 2 is enclosed by the module `Swimmable`. Therefore, it references the `Swimmable` module.

````ruby
module Swimmable          # 1
  def self.swimmable?     # 2
    true                  # 3
  end                     # 4
end                       # 5
````

There are two scenarios when we have to use `self` as an explicit caller:

The first is when we call a setter inside an instance method as in line 5. If we omit the `self`, Ruby will take regard it as a local variable initialization.

````ruby
class Person            # 1
  attr_writer :name     # 2
                        # 3
  def initialize(n)     # 4
    self.name = n       # 5
  end                   # 6
end                     # 7
````

The second is when we define a class method. If we omit the `self`, an instance method is defined instead. In the following example, a class method called `species` is defined in the `Person` class.

````ruby
class Person
  def self.species
    "Homo sapiens"
  end
end
````

### When would you call a method with `self`?

Inside an instance method, when we want to call a setter, we would call it with `self` so as to disambiguate that from local variable initialization.

### Why private methods cannot have a caller?

Private methods are methods that can only be invoked from within the class itself, they cannot be called outside of it. Therefore, for private methods, its caller is always the calling object itself, i.e., they are implicitly called on `self`. That's why we don't need to explicitly state a caller.

There is one exception for this. When we call a setter method from within an instance method, we need to explicitly state the caller `self` so as to disambiguate it from local variable initialization. As illustrated in the code snippet below, the setter for the attribute `name` is private. When we call the private setter method `name=` from within the method `change_name`, we need to explicitly state the caller `self`. Otherwise, Ruby will regard it as local variable initialization.

````ruby
class Person
  def initialize(name)
    @name = name
  end
  
  def change_name(name)
    self.name = name.capitalize
  end
  
  private
  
  attr_writer :name
end

jason = Person.new('Jayson')
p jason # => #<Person:0x00000000027af420 @name="Jayson">

jason.change_name('jason')
p jason # => #<Person:0x00000000027af420 @name="Jason">
````

From Ruby 2.7 onwards, private methods can explicitly be called on `self`.

### What are class methods?

Class methods are functionalities that are related to the class, instead of its instances. They are invoked on the class name, without instantiating any objects. To define a class method, we would prepend the method name with `self.` in class definition.

### What is the purpose of a class variable?

Class variables are used to keep track of a class's information as a whole, instead of its instances.

### What is a constant variable?

A constant variable is a constant that is not supposed to be re-assigned to a new value after initialization. Although Ruby allows us to change a constant, it just warns us without raising an error.

To define a constant variable in Ruby, choose a variable name that starts with a capital letter or with full capital letters like so:

````ruby
PI = 3.14
````

### What is the default `to_s` method that comes with Ruby, and how do you override this? What are some important attributes of the `to_s` method?

The `to_s` method returns a string representation of the calling object. By default, the string representation includes the class name of the calling object and its encoding of the object ID. To override the default `to_s` method, we can define our own custom `to_s` method in our class.

There are two important attributes of the `to_s` method:

First, every time when we invoke the `puts` method, it automatically calls `to_s` on its argument (except for arrays, where it prints on separate line the result of `to_s` being called on every element). In other words, `puts obj` is equivalent to `puts obj.to_s`.

Second, the `to_s` method is also invoked on objects in string interpolation.

### From within a class, when an instance method uses `self`, what does it reference?

From within a class, `self` references the **calling object**.

### What happens when you use `self` inside a class but outside of an instance method?

Inside a class but outside of an instance method, `self` references the class itself.

### Why do you need to use `self` when calling private setter methods?

If we do not use `self`, Ruby will think that we are initializing a local variable. The use of `self` is to disambiguate that.

Note: This is an exception in Ruby. Normally we don’t use `self` when calling a private method, as `self` would reference the calling object, which is not allowed. However, from Ruby 2.7 on, it is legal to use call private methods with `self` as a caller in a class.

### Why use `self`, and how does `self` change depending on the scope it is used in?

We use `self` if we want to explicitly state the calling object, although what `self` references depends on the scope it is used in.

Typically there are two situations where we need to use `self`:

- When we call a setter method inside an instance method. We need to use `self` to disambiguate that from local variable initialization.
- When we define a class method.

Depending on the scope where `self` is used in, `self` can reference different things:

- Inside an instance method, `self` references the calling object.
- Inside a class method, `self` references the class itself.
- Elsewhere, `self` references the enclosing structure.

### Why is it generally a bad idea to override methods from the `Object` class, and which method is commonly overridden?

All custom classes we defined are subclasses of the `Object` class, and thus our custom classes inherit many critical funcionalities from the `Object` class. Overriding methods from the `Object` class may lead to unexpected results.

However, the commonly overridden behavior is the `to_s` method. Its invocation retruns a string representation of the calling object. By default, it returns the object's class name and the encoding of its ID. By overriding the `to_s` method, we can define our own string representation for objects of our custom classes.

### What happens when you call the `p` method on an object? And the `puts` method?

When we call the `p` method on an object, Ruby automatically calls the `inspect` method on it and the return value is outputted to the console. Therefore `p obj` is equivalent to `puts p.inspect`.

When we call the `puts` methods on an object, Ruby automatically call the `to_s` method on it and the return value is outputted to the console. Therefore, `puts obj` is equivalent to `puts obj.to_s`.

### What are the scoping rules for class variables? What are the two main behaviors of class variables?

Class variables are scoped at the class level. Once they are defined, they can be referenced and manipulated in class methods and instance methods.

There are two main behaviors of class variables:

- All objects of the class share the same copy of class variables
- Class methods and instance methods can access class variables, regardless of where the class variables are initialized.

### What are the scoping rules for constant variables?

Constant variables are scoped lexically. That means where a constant is defined determines its availability.

When Ruby resolves a constant, it first searches the surrounding structure (i.e., the lexical scope). If the constant is not found, Ruby then looks it up in the inheritance chain, and finally in the main scope.

### How does sub-classing affect instance variables?

Unlike instance methods, instance variables and their values are not inherited.

An instance can access an instance variable when the instance method that initializes the instance variable is executed.

### How do you print the object so you can see the instance variables and their values along with the object?

We can do so by invoking the `p` method with the object as an argument. The `p` method implicitly calls the `inspect` method on the object so that we can see the instance variables and their values along with the object.

### How do you override the `to_s` method? What does the `to_s` method have to do with `puts`?

All custom classes inherit the `to_s` method from the `Object` class. To override the `to_s` method, we can define our own `to_s` method in our custom class.

When we invoke the `puts` method with an argument, the `puts` method implicitly calls the `to_s` method on its argument.

### What is the default return value of `to_s` when invoked on an object? Where could you go to find out if you want to be sure?

The `to_s` method returns a string representation of the calling object which, by default, consists of the name of the object's class and the encoding of the object ID.

This can be shown by the following snippet:

````ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end

jason = Person.new('Jason', 30)
puts jason.to_s # => #<Person:0x0000000001f47c10>
````

### Why is it generally safer to use an explicit `self.` caller when you have a setter method unless you have a good reason to use the instance variable directly?

It is generally safer to use a setter method because in the setter there could be a value check or operation performed. If we use the instance variable directly, it may be assigned some undesired values.

## Fake Operators and Equality

### What is a fake operator?

A fake operator in Ruby is actually a method. It looks like an operator because of Ruby's syntactical sugar.

For example, considering the code snippet `1 + 1 == 2`, the `==` is actually a method in Ruby. Therefore `1 + 1 == 2` is equivalent to `(1 + 1).==(2)`. We can write `1 + 1 == 2` because of Ruby's syntactical sugar. It makes the code more natural to read.

### How does equivalence work in Ruby?

--

### How do you determine if two variables actually point to the same object?

There are two ways to do so in Ruby.

First, we can check if the object IDs of the objects that the two variables point is the same:

````ruby
arr1 = [1, 2, 3]
arr2 = arr1
puts arr1.object_id == arr2.object_id # => true
````

Second, we can use the `equal?` method:

````ruby
arr1 = [1, 2, 3]
arr2 = arr1
puts arr1.equal? arr2 # => true
````

### What is `==` in Ruby? How does `==` know what value to use for comparison?

`==` is a method originally defined in the `BasicObject` class. As all classes are subclasses of `BasicObject`, they all inherit the `==` method. The `BasicObject#==` method check if two objects are the same object by comparing their object IDs. In order to let Ruby know what value to use for comparison, we should define our own custom `==` method in our custom class.

In the following example, two `Person` objects are said to be the same if they have the same name:

````ruby
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def ==(other_person)
    @name == other_person.name
  end
end

person1 = Person.new('Jason')
person2 = Person.new('Jason')
puts person1 == person2 # => true
````

### Is it possible to compare two objects of different classes?

It is possible to compare two objects of different classes. It all depends on how we define the `==` method.

For example, we can compare an integer and a float number:

````ruby
45 == 45.0 # => true
45.0 == 45 # => true
````

### What do you get for free when you define a `==` method?

When we define a `==` method, we get a `!=` method for free.

````ruby
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def ==(other_person)
    @name == other_person.name
  end
end

person1 = Person.new('Jason')
person2 = Person.new('Jason')
puts person1 != person2 # => false
````

### What is the `===` method?

The `===` method is implicitely used by the `case` statement.

Consider the following example:

````ruby
case score
when 90..100
  puts 'A'
when 70...90
  puts 'B'
when 50...70
  puts 'C'
when 30...50
  puts 'D'
else
  puts 'U'
end
````

The above `case` statement can be translated into the following `if` statement:

````ruby
if (90..100) === score
  puts 'A'
elsif (70...90) === score
  puts 'B'
elsif (50...70) === score
  puts 'C'
elsif (30...50) === score
  puts 'D'
else
  puts 'U'
end
````

The `if` clause `(90...100) == score` can be interpreted as: is the object referenced by `score` a member of the group `90..100`?

````ruby
(90..100) === 90 # => true
(90..100) === 99.9 # => true
(90..100) === 101 # => false
````

### What is the `equal?` method?

The `equal?` method check if the two objects in question are the same object. Take the following as an example:

````ruby
str1 = 'This is a string.'
str2 = 'This is a string.'
str1_copy = str1

str1.equal?(str2) # => false
str1.equal?(str1_copy) # => true
````

Although `str1` and `str2` are strings with the same value `'This is a string.'`, they are actually two different objects. Therefore `str1.equal?(str2)` returns `false`.

Both `str1` and `str1_copy` point to the same `String` object. Therefore `str1.equal?(str1_copy)` returns `true`.

### What is the `eql?` method?

The `eql?` method checks if two objects have the same value and are of the same type. The `eql?` method is implicitely used by `Hash` to determine the equality among its members.

````ruby
str1 = 'This is a string.'
str2 = 'This is a string.'
str1.eql?(str2) # => true

num1 = 9
num2 = 9.0
num1.eql?(num2) # => false
````

### What is interesting about the `object_id` method and its relation to symbols and integers?

Unlike strings and many other mutable data types, if two symbols or integers have the same value, they are the same object. We can check this by comparing the object IDs:

````ruby
sym1 = :symbol
sym2 = :symbol
puts sym1.object_id == sym2.object_id # => true

int1 = 8
int2 = 8
puts sym1.object_id == sym2.object_id # => true
````

This is so because symbols and integers are immutable in Ruby, and this is a performance optimisation done by Ruby.

### When do shift method makes the most sense?

The shift method make the most sense when working with collections like strings and arrays:

````ruby
# to add a character to a string
'hello' << '!' # => 'hello!'

# to add an element to an array
[1, 2, 3, 4] << 5 # => [1, 2, 3, 4, 5]
````

### Explain how the element reference getter and element assignment setter methods work, and their corresponding syntactical sugar.

Take an array, which is a kind of collection, as an example. To get and set its element, we can use the methods `Array#[]` and `Array#[]=` respectively.

Let's say we have an array `arr = ['a', 'b', 'c', 'b', 'e']`. To get the second element, we can invoke the `Array#[]` method on `arr` like `arr.[](1)` which returns `'b'`. To set the fourth element (`'b'`) to `'d'`, we can invoke the `Array#[]=` method on `arr` like `arr.[]=(3, 'd')` which mutates `arr` to `['a', 'b', 'c', 'd', 'e']`.

Thanks to Ruby's syntactical sugar, the above code can be more naturally written as:

````ruby
arr = ['a', 'b', 'c', 'b', 'e']

# element reference getter
arr[1] # => 'b'

# element assignment setter
arr[3] = 'd'
arr # => ['a', 'b', 'c', 'd', 'e']
````
