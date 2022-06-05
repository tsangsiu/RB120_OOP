class MyCar
  attr_accessor :color
  attr_reader :year

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

  # def color
  #   @color
  # end

  # def color=(color)
  #   @color = color
  # end

  # def year
  #   @year
  # end
end

my_car = MyCar.new(2022, 'Red', 'JT')

p my_car.color
my_car.color = 'Black'
p my_car.color

p my_car.year
# my_car.year = 2008 # => NoMethodError
