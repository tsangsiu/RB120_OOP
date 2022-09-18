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

## Instance/Class Methods, `self` and `to_s`

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
