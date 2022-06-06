class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

=begin

If we run `kitty.class.generic_greeting`, we get the same output to the console,
because `kitty.class` returns the class `Cat`.

=end

kitty = Cat.new
kitty.class.generic_greeting
