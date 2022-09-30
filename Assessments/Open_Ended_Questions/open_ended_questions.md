# Open-Ended Questions

## Reading OO Code

## Classes and Objects, Encapsulation, Collaborator Objects and Public/Private/Protected Methods

### What is encapsulation? How does encapsulation relate to the public interface of a class?

Encapsulation is to restrict access to certain instance methods, and only expose functionalities that users of the object need.

Instance methods are encapsulated in an object by making them private. Instance methods that are public are what we called the public interfaces of a class. They are the channels through which users interact with the objects.

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

## Polymorphism, Inheritance, Modules and Method Lookup Path

### Why should methods in mixin modules be defined without using `self.` in the definition?

Refer to the code below, if a method in a mixin module is defined with `self.` in the definition, it becomes a module method and can only be called by `Swimmable.swim` or `Swimmable::swim`. Furthermore, the method is not available to all instances of the class where the module is mixed in.

```ruby
module Swimmable
  def self.swim; end
end
```

## `attr_*`, Getters and Setters, and Referencing and Setting Instance Variables

### What is a getter method?

A getter method is a method that returns the value referenced by an object's instance variable. The value could be modified by the getter method.

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

We can also define our own getter, in which we can modify the value reference by the instance variable. In practice, the name of the getter is usually the same as that of the instance variable:

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

### What are class methods?

Class methods are functionalities that are related to the class, instead of its instances. They are invoked on the class name, without instantiating any objects. To define a class method, we would prepend the method name with `self.` in class definition.

### What is the purpose of a class variable?

Class variables are used to keep track of a class's information as a whole, instead of its instances.

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
- Inside a class but outside an instance method, `self` references the class itself.

### Why is it generally a bad idea to override methods from the `Object` class, and which method is commonly overridden?

All custom classes we defined are subclasses of the `Object` class, and thus our custom classes inherit many critical funcionalities from the `Object` class. Overriding methods from the `Object` class may lead to unexpected results.

However, the commonly overridden behavior is the `to_s` method. Its invocation retruns a string representation of the calling object. By default, it returns the object's class name and the encoding of its ID. By overriding the `to_s` method, we can define our own string representation for objects of our custom classes.

### What happens when you call the `p` method on an object? And the `puts` method?

When we call the `p` method on an object, Ruby automatically calls the `inspect` method on it and the return value is outputted to the console. Therefore `p obj` is equivalent to `puts p.inspect`.

When we call the `puts` methods on an object, Ruby automatically call the `to_s` method on it and the return value is outputted to the console. Therefore, `puts obj` is equivalent to `puts obj.to_s`.

## Fake Operators and Equality

### What is a fake operator?

A fake operator in Ruby is actually a method. It looks like an operator because of Ruby's syntactical sugar.

For example, considering the code snippet `1 + 1 == 2`, the `==` is actually a method in Ruby. Therefore `1 + 1 == 2` is equivalent to `(1 + 1).==(2)`. We can write `1 + 1 == 2` because of Ruby's syntactical sugar. It makes the code more natural to read.

### How does equivalence work in Ruby?

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

### What is the `equal?` method?

### What is the `eql?` method?

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
