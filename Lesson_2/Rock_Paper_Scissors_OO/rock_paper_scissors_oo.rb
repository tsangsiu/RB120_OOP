class Player
  attr_accessor :name, :move, :winner, :score, :grand_winner

  def initialize
    set_name
    @winner = false
    @score = 0
    @grand_winner = false
  end
end

class Human < Player
  def set_name
    name = ""
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid  choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (scissors? && other_move.paper?) ||
      (paper? && other_move.rock?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (scissors? && other_move.rock?) ||
      (paper? && other_move.scissors?)
  end

  def to_s
    @value
  end
end

class RPSGame
  attr_accessor :human, :computer

  SCORE_TO_WIN = 10

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def determine_round_winner
    if human.move > computer.move
      human.winner = true
    elsif human.move < computer.move
      computer.winner = true
    end
  end

  def add_score
    if human.winner
      human.score += 1
    elsif computer.winner
      computer.score += 1
    end
  end

  def display_round_winner
    if human.winner
      puts "#{human.name} won!"
    elsif computer.winner
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name}'s score: #{human.score}"
    puts "#{computer.name}'s score: #{computer.score}"
  end

  def determine_grand_winner
    if human.score >= SCORE_TO_WIN
      human.grand_winner = true
    elsif computer.score >= SCORE_TO_WIN
      computer.grand_winner = true
    end
  end

  def display_grand_winner
    if human.grand_winner
      puts "#{human.name} is the grand winner!"
    elsif computer.grand_winner
      puts "#{computer.name} is the grand winner!"
    end
  end

  def grand_winner?
    human.score >= SCORE_TO_WIN || computer.score >= SCORE_TO_WIN
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    answer.downcase == 'y'
  end

  def play
    display_welcome_message

    loop do
      reset_game
      until grand_winner?
        reset_round
        human.choose
        computer.choose
        display_moves
        determine_round_winner
        add_score
        display_round_winner
        display_score
      end
      determine_grand_winner
      display_grand_winner
      break unless play_again?
    end

    display_goodbye_message
  end

  private

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def reset_grand_winner
    human.grand_winner = false
    computer.grand_winner = false
  end

  def reset_game
    reset_score
    reset_grand_winner
  end

  def reset_round_winner
    human.winner = false
    computer.winner = false
  end

  def reset_round
    reset_round_winner
  end
end

RPSGame.new.play
