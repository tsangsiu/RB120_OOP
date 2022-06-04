=begin

A module contains methods that can be used by other classes.

This is a way to achieve polymorphism.

To use methods in a module in a class, use the `include` method followed by the module name when defining a class

=end

module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class Person
  include Speak
end

Jason = Person.new
Jason.speak("Hi!")
