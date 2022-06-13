module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class Vehicle
  @@number_of_vehicles = 0

  def initialize
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  def self.gas_mileage(gallons, miles)
    miles / gallons
  end
end

class MyCar < Vehicle
  NUMBER_OF_WHEELS = 4  
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_WHEELS = 8
end

puts Vehicle.ancestors
puts
puts MyCar.ancestors
puts
puts MyTruck.ancestors
