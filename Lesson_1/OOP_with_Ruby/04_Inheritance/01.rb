class Vehicle
  def self.gas_mileage(gallons, miles)
    miles / gallons
  end
end

class MyCar < Vehicle
  NUMBER_OF_WHEELS = 4  
end

class MyTruck < Vehicle
  NUMBER_OF_WHEELS = 8
end
