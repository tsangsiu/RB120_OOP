class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

=begin

As `make_one_year_older` is an instance method, the `self` on line 10 refers
to the instance that calls the method.

=end
