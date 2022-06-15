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
The `self` on line 10 refers to the instance that calls the `make_one_year_older`
method.
=end