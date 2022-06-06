class Vehicle
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end


class MyCar < Vehicle
  NUMBER_OF_WHEEL = 4
end

class MyTruck < Vehicle
  NUMBER_OF_WHEEL = 6
end
