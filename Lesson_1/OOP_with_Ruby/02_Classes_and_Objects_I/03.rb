class MyCar
  attr_reader :year, :color

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    current_speed = 0
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

my_car = MyCar.new(2022, 'Red', 'JT')

p my_car.color
my_car.spray_paint('Black')
p my_car.color
