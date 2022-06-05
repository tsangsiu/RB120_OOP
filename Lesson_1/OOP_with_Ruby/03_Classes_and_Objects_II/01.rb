class MyCar
  attr_reader :year, :color

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
end

MyCar.gas_mileage(13, 351)
