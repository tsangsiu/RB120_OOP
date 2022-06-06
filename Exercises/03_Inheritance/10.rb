module Transportation
  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end
end

my_truck = Transportation::Truck.new
p my_truck
