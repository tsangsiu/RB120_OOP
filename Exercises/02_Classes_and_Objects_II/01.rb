class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

=begin

It will output "Hello! I'm a cat!" to the console.

`kitty.class` returns the class of the object that `kitty` references, which is 
`Cat`. The class method is then called on `Cat`, returning "Hello! I'm a cat!".

=end

kitty = Cat.new
kitty.class.generic_greeting
