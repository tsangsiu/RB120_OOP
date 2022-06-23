class Vehicle
  attr_reader :make, :model
  
  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

=begin

Further Exploration

It would make sense to define a `wheels` method in `Vehicle` even though all of
the remaining class would be overriding it. Implemented like that, all
subclasses of `Vehicle` would have the `wheels` method. This would make
polymorphism via inheritance easier.

It is true that not all vehicles have wheels (boats have no wheels). Put it in
the other way, vehicles which have no wheels have 0 wheels. Therefore, the
`wheels` method in the `Vehicle` class would be defined like this:

=end

class Vehicle
  attr_reader :make, :model
  
  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def wheels
    0
  end
  
  def to_s
    "#{make} #{model}"
  end
end
