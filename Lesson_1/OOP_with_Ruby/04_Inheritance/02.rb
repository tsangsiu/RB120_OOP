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

class MyCar < Vehicle
  NUMBER_OF_WHEEL = 4
end

class MyTruck < Vehicle
  NUMBER_OF_WHEEL = 6
end

my_car_1 = MyCar.new
my_car_2 = MyTruck.new
p Vehicle.number_of_vehicle
