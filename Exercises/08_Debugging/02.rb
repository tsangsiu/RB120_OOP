class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

=begin
Line 50 raises `ArgumentError`.

On line 50, a new `SongBird` object is instantiated with three arguments passed
in to the `SongBird::new` method. The `SongBird::new` method triggers the
invocation of `SongBird#initialize`. Upon its invocation, the `super` keyword
invokes the method of the same name in its parent class (which is `Animal#initialize`)
and pass all arguments that are passed to `SongBird#initialize` to `Animal#initialize`.
As `Animal#initialize` only accepts two arguments, hence raising `ArgumentError`.

To alter the code so that it runs without error, we can alter line 37 as follows:
`super(diet, superpower)`
=end

=begin
Further Exploration

The `FlightlessBird#initialize` method is not necessary.

When the method is invoked, the `super` keyword invokes the method of the same
name up in the method lookup path, which is `Animal#initialize`, and passes all
arguments that are passed to `FlightlessBird#initialize` to `Animal#initialize`.
This initializes the two instance variables `@diet` and `@superpower` to the
objects referenced by `diet` and `superpower` respectively.

However, without the `FlightlessBird#initialize` method, Ruby will look for the
`initialize` method up in the method lookup path when a new `FlightlessBird`
object is instantiated. It turns out that the `Animal#initialize` is invoked
when there is no `FlightlessBird` method. Hence, `FlightlessBird#initialize`
is not necessary.
=end
