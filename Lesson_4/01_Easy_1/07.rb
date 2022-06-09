=begin
By default, the `to_s` method will return the name of the object's class and an
encoding of the object ID.
=end

class Person
  def initialize(name)
    @name = name
  end
end

jason = Person.new('JT')
puts jason
