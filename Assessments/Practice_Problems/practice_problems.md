# Practice Problems

## 1

What is the output and why? What does this demonstrate about instance variables that differentiates them from local variables?

````ruby
class Person            # 1
  attr_reader :name     # 2
                        # 3
  def set_name          # 4
    @name = 'Bob'       # 5
  end                   # 6
end                     # 7
                        # 8
bob = Person.new        # 9
p bob.name              # 10
````

The line 10 outputs `nil` to the console.

On line 9, a new `Person` object is instantiated and assigned to the local variable `bob`. The `Person` class has an instance variable `@name` defined for all its instances. However, it is not initialized upon instantiation. The instance variable `@name`, unlike local variables, points to `nil`. For local varables, a `NameError` will be thrown when it is uninitialized.
