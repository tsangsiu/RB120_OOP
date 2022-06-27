class Pet
  attr_reader :type, :name
  attr_accessor :adopted
  
  @@pets = []

  def initialize(type, name)
    @type = type
    @name = name
    @adopted = false
    @@pets << self
  end

  def to_s
    "a #{type} named #{name}"
  end
  
  def self.all_pets
    @@pets
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    puts pets
  end
end

class Shelter
  attr_accessor :pets, :adopters

  def initialize
    @pets = Pet.all_pets
    @adopters = []
  end

  def adopt(owner, pet)
    adopters << owner unless adopters.include?(owner)
    owner.add_pet(pet)
    pet.adopted = true
  end

  def print_adoptions
    adopters.each do |adopter|
      puts "#{adopter.name} has adopted the following pets:"
      adopter.print_pets
      puts
    end
  end
  
  def unadopted_pets
    Pet.all_pets.select { |pet| pet.adopted == false }
  end
  
  def print_unadopted_pets
    puts "The Animal Shelter has the following unadopted pets:"
    unadopted_pets.each do |unadopted_pet|
      puts unadopted_pet
    end
    puts
  end
  
  def number_of_unadopted_pets
    unadopted_pets.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_unadopted_pets
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal Shelter has #{shelter.number_of_unadopted_pets} unadopted pets."

=begin

# Further Exploration

I only modified the interface `Shelter#adopt`.

=end
