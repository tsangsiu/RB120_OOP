class Person
  def name=(name)
    self.first_name, self.last_name = name.split
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  private
  
  attr_accessor :first_name, :last_name
end

class Person
  def name=(name)
    @first_name, @last_name = name.split
  end
  
  def name
    "#{@first_name} #{@last_name}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
