class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  ROUND_RESULT_MESSAGE = {
    high: 'Your guess is too high.',
    low: 'Your guess is too low.',
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high: :lose,
    low: :lose,
    match: :win
  }.freeze

  GAME_END_MESSAGE = {
    lose: 'You have no more guesses. You lost!',
    win: 'You won!'
  }.freeze

  def initialize
    @number_to_guess = nil
  end

  def play
    reset
    result = play_game
    display_game_end_message(result)
  end

  private

  def reset
    @number_to_guess = rand(RANGE)
  end

  # return a symbol indicating if the player wins
  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      guess = player_guess
      result = check_guess(guess)
      puts ROUND_RESULT_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining_guesses)
    puts
    if remaining_guesses == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining_guesses} guesses remaining."
    end
  end

  def player_guess
    guess = nil
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.strip
      break if valid_number?(guess)
      print 'Invalid guess. '
    end
    guess.to_i
  end

  def valid_number?(guess)
    guess =~ /\A[-+]?\d+\z/ &&
      guess.to_i >= 1 && guess.to_i <= 100
  end

  def check_guess(guess)
    if guess > @number_to_guess
      :high
    elsif guess < @number_to_guess
      :low
    else
      :match
    end
  end

  def display_game_end_message(result)
    puts '', GAME_END_MESSAGE[result]
  end
end

game = GuessingGame.new
game.play
