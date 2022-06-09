class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

=begin
The `Pizza` class has an instance variable, because an instance variable is 
prepended with an '@'.
=end

p Fruit.new('fruit').instance_variables # => []
p Pizza.new('pizza').instance_variables # => [:@name]
