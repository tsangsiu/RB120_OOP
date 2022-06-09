class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

=begin

If we added a `play` method to the `Bingo` class, the method will override the
`play` method in the `Game` class.

=end
