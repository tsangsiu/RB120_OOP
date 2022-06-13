class MyCar
  attr_reader :color, :year, :model
  
  def self.gas_mileage(gallons, miles)
    miles / gallons
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end
  
  def speed_up(speed)
    @current_speed += speed
  end
  
  def brake(speed)
    @current_speed -= speed
  end
  
  def shut
    @current_speed = 0
  end
  
  def spray_paint(color)
    @color = color
  end
  
  def to_s
    "My car is a #{color}, #{year}, #{model}!"
  end
end

my_car = MyCar.new("2022", "red", "JT")
puts my_car
