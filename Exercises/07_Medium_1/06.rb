class GuessingGame
  def initialize
    @number_to_guess = (1..100).to_a.sample
    @guess_remaining = 7
    @win = false
  end
  
  def play
    until @win || @guess_remaining == 0
      puts "You have #{@guess_remaining} guesses remaining."
      number = get_player_guess

      if number > @number_to_guess
        puts 'Your guess is too high.'
      elsif number < @number_to_guess
        puts 'Your guess is too low.'
      else
        puts "That's the number!"
        @win = true
      end

      @guess_remaining -= 1

      puts
      if @win
        puts 'You won!'
      elsif @guess_remaining == 0
        puts 'You have no more guesses. You lost!'
      end
    end
  end
  
  private
  
  def get_player_guess
    number = nil
    loop do
      print 'Enter a number between 1 and 100: '
      number = gets.chomp.strip.to_i
      break if valid_number?(number)
      print 'Invalid guess. '
    end
    number
  end

  def valid_number?(number)
    number >= 1 && number <= 100
  end
end

game = GuessingGame.new
game.play
