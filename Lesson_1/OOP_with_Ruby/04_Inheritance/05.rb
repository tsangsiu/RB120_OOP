module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class Vehicle
  attr_reader :color, :year, :model, :current_speed
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  def self.gas_mileage(gallons, miles)
    miles / gallons
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(speed)
    @current_speed += speed
  end
  
  def brake(speed)
    @current_speed -= speed
  end
  
  def shut_down
    @current_speed = 0
  end
  
  def spray_paint(color)
    @color = color
  end
end

class MyCar < Vehicle
  NUMBER_OF_WHEELS = 4
  
  def to_s
    "My car is a #{color}, #{year}, #{model}!"
  end
end

class MyTruck
  include Towable

  NUMBER_OF_WHEELS = 8

  def to_s
    "My truck is a #{color}, #{year}, #{model}!"
  end
end
