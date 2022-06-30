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

If we added a `play` method to the `Bingo` class, when we call `play` on a
`Bingo` object, `Bingo#play` is invoked instead of `Game#play`, because
`Bingo#play` overrides `Bingo#play`.

=end
