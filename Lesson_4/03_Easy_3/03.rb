class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

angry_cat1 = AngryCat.new(3, "Egg")
angey_cat2 = AngryCat.new(4, "Zac")
