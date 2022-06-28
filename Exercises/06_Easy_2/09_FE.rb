# Further Exploration

module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Animal
  include Walkable
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
end

class Person < Animal
  private

  def gait
    "strolls"
  end
end

class Cat < Animal
  private

  def gait
    "saunters"
  end
end

class Noble < Person
  attr_reader :title
  
  def initialize(name, title)
    super(name)
    @title = title
  end
  
  def to_s
    "#{title} #{name}"
  end
  
  private
  
  def gait
    "struts"
  end
end

class Cheetah < Cat
  private

  def gait
    "runs"
  end
end

byron = Noble.new("Byron", "Lord")
puts byron.walk # => "Lord Byron struts forward"

puts byron.name # => "Byron"
puts byron.title # => "Lord"
