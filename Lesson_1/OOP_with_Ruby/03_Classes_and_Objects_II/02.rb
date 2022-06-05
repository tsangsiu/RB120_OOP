class MyCar
  attr_reader :year, :color, :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    current_speed = 0
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def speed_up(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_down
    @speed = 0
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
