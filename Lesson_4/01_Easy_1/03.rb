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

small_car = Car.new
small_car.go_fast # => "I am a Car and going super fast!"

=begin

The `self` in the `go_fast` method represents the calling object.

In the example, the method `go_fast` is called on the object which `small_car`
references, which is a `Car` object. Hence `self.class` returns `Car`.

`Car` is then interpolated inside of a String.

Therefore, when `go_fast` is called on `small_car`, it outputs `I am a Car and
going super fast!` to the console.

=end
