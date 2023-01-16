class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  def ==(geolocation_obj)
    self.latitude == geolocation_obj.latitude &&
    self.longitude == geolocation_obj.longitude
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

=begin
On line 39, we are comparing the two `GeoLocation` objects returned by `ada.location`
and `grace.location` using the `==` method.

If we do not define our own `==` method in the `GeoLocation` class, by default,
the `==` method inherits its behaviours from the `BasicObject` class, which
checks if the two objects in question are the same object. As those objects are
two different objects, which were separately instantiated on lines 30 and 33,
`ada.location == grace.location` returns `false`.

In order to check if the locations of two `GeoLocation` is the same, we can
define our own `==` method in the `GeoLocation` class, which overrides
`BasicObject#==`, like so:

````ruby
def ==(geolocation_obj)
  self.latitude == geolocation_obj.latitude &&
  self.longitude == geolocation_obj.longitude
end
````
=end
