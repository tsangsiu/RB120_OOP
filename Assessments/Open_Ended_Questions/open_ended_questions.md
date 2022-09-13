# Open-Ended Questions

## Reading OO Code

## Classes and Objects, Encapsulation, Collaborator Objects and Public/Private/Protected Methods

## Polymorphism, Inheritance, Modules and Method Lookup Path

### Why should methods in mixin modules be defined without using `self.` in the definition?

Refer to the code below, if a method in a mixin module is defined with `self.` in the definition, it becomes a module method and can only be called by `Swimmable.swim` or `Swimmable::swim`. Furthermore, the method is not available to all instances of the class where the module is mixed in.

```ruby
module Swimmable
	def self.swim; end
end
```

## `attr_*`, Getters and Setters, and Referencing and Setting Instance Variables

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
