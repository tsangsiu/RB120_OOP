class House
  include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end
  
  def <=>(other_house)
    price <=> other_house.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

=begin

Further Exploration

The technique we employ here to compare houses might not be a good one. Because
when we talk about "house 1 is larger than house 2", we usually mean the area,
not the price. For those who don't know the implementation of `#<` and `#>`
might unexpected outcome.

It would be a good idea to include the Comparable module for classes where
the comparsion is initutive like Integers, Float and Strings.

=end
