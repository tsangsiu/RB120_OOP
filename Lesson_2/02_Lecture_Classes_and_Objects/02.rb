class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    name_parts = full_name.split
    self.first_name = name_parts.first
    self.last_name = name_parts.size > 1 ? name_parts.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
