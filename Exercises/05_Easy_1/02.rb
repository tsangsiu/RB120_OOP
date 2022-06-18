class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # => Fluffy
puts fluffy # => My name is FLUFFY.
puts fluffy.name # => FLUFFY
puts name # => FLUFFY

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # => Fluffy
puts fluffy # => My name is FLUFFY.
puts fluffy.name # => Fluffy
puts name # => Fluffy

# Further Exploration

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name # => "42"
puts fluffy # => "My name is 42."
puts fluffy.name # => "42"
puts name # => 43

=begin

On line 55, the local variable `name` is assigned to the Integer 42.

On line 56, a `Pet` object is instantiated with an attribute `@name = "42"`. The 
object is then assigned to the local variable `fluffy`.

On line 57, The local variable `name` is incremented by 1.

On line 58, when the getter method of `name` is called on `fluffy`, it returns
the value that the instance variable `name` of `fluffy` points to, which is "42".

On line 59, when the `puts` method is called with the object `fluffy` as an
argument, it calls `to_s` on `fluffy` before outputting the result to the 
console. Upon the method invocation of `to_s`, the mutating method `upcase!` is
called on `@name`, which modifies `"42"` in place to the same String `"42"`,
thus outputting `My name is 42.` to the console.

As `@name` now points to the String `"42"`, the line 60 outputs `"42"` to the
console.

As `name` was incremented by 1 on line 57, the line 61 outputs `43` to the
console.

=end
