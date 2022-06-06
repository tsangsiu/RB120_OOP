class Vehicle
  @@number_of_vehicle = 0
  
  def self.number_of_vehicle
    @@number_of_vehicle
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def initialize
    @@number_of_vehicle += 1
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class MyCar < Vehicle
  NUMBER_OF_WHEEL = 4
end

class MyTruck < Vehicle
  include Towable
  
  NUMBER_OF_WHEEL = 6
end

puts Vehicle.ancestors
puts
puts MyCar.ancestors
puts
puts MyTruck.ancestors
