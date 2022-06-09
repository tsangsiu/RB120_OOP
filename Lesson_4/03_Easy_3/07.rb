class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

=begin

- Line 2 is not needed, as the program doesn't use any setter or getter methods for those instance variables.
- The `return` keyword on line 10 doesn'y add any value, as Ruby always implicitly return the result of the last line.

=end
