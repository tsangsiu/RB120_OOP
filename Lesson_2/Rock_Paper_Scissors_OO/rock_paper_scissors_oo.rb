class Player
  attr_accessor :name, :score, :move, :move_history,
                :round_winner, :grand_winner

  def initialize
    set_name
  end
end

module Helpable
  TICK = "\xE2\x9C\x94"
end

class Human < Player
  def set_name
    name = ""
    loop do
      puts "What's your name?"
      name = gets.chomp.strip
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    @name = name
  end

  def choose
    choice = nil
    loop do
      puts "Please choose [r]ock, [p]aper, [sc]issors, [l]izard, or [sp]ock:"
      choice = gets.chomp.strip.downcase
      break if Move::VALID_VALUES.keys.include?(choice)
      puts "Sorry, invalid choice."
    end
    @move = Move.create(Move::VALID_VALUES[choice])
  end
end

class Computer < Player
  def set_name
    @name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose(name)
    @move = Move.create(Move.values(name).sample)
  end
end

class Move
  VALID_VALUES = {
    'r' => 'rock', 'rock' => 'rock',
    'p' => 'paper', 'paper' => 'paper',
    'sc' => 'scissors', 'scissors' => 'scissors',
    'l' => 'lizard', 'lizard' => 'lizard',
    'sp' => 'spock', 'spock' => 'spock'
  }
  VALUES = {
    "R2D2" => ['rock'],
    "Hal" => ['rock', ['scissors'] * 4, ['lizard'] * 2,
              ['spock'] * 2].flatten,
    "Chappie" => [['paper'] * 4, 'scissors', ['lizard'] * 2,
                  ['spock'] * 2].flatten,
    "Sonny" => [['rock'] * 4, 'paper', ['lizard'] * 2, ['spock'] * 2].flatten
  }

  def self.values(name = nil)
    if VALUES.key?(name)
      VALUES[name]
    else
      VALID_VALUES.values.uniq
    end
  end

  def self.create(value)
    case value
    when 'rock'     then Rock.new
    when 'scissors' then Scissors.new
    when 'paper'    then Paper.new
    when 'lizard'   then Lizard.new
    when 'spock'    then Spock.new
    end
  end

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

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def to_s
    @value.capitalize
  end
end

class Rock < Move
  def initialize
    super('rock')
  end

  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Scissors < Move
  def initialize
    super('scissors')
  end

  def >(other_move)
    other_move.paper? || other_move.lizard?
  end

  def <(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Paper < Move
  def initialize
    super('paper')
  end

  def >(other_move)
    other_move.rock? || other_move.spock?
  end

  def <(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Lizard < Move
  def initialize
    super('lizard')
  end

  def >(other_move)
    other_move.paper? || other_move.spock?
  end

  def <(other_move)
    other_move.rock? || other_move.scissors?
  end
end

class Spock < Move
  def initialize
    super('spock')
  end

  def >(other_move)
    other_move.rock? || other_move.scissors?
  end

  def <(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class RPSGame
  def initialize
    system "clear"
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_message
    if read_rules?
      display_rules
      prompt_to_continue
    end
    main_game_loop
    display_goodbye_message
  end

  private

  attr_accessor :round_number, :human, :computer

  SCORE_TO_WIN = 10
  PAGE_WIDTH = 50
  RULES = <<-MSG
Scissors cuts Paper
Paper covers Rock
Rock crushes Lizard
Lizard poisons Spock
Spock smashes Scissors
Scissors decapitates Lizard
Lizard eats Paper
Paper disproves Spock
Spock vaporizes Rock
Rock crushes Scissors
=> The first player reaches #{SCORE_TO_WIN} wins wins the game.
  MSG

  def display_welcome_message
    puts "** Welcome to Rock, Paper, Scissors, #{human.name}! **"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def prompt_to_continue
    puts "Press [enter] to continue"
    gets
    system "clear"
  end

  def read_rules?
    answer = nil
    loop do
      puts "Would you like to read the rules? [Y/N]"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be Y or N."
    end
    answer.downcase == 'y'
  end

  def display_rules
    puts '-' * PAGE_WIDTH
    puts '- Rules -'
    puts RULES
    puts '-' * PAGE_WIDTH
  end

  def reset_round_number
    @round_number = 0
  end

  def main_game_loop
    loop do
      reset_game
      until grand_winner?
        process_round
        display_round
      end
      determine_grand_winner
      display_grand_winner
      break unless play_again?
    end
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def reset_move
    human.move = nil
    computer.move = nil
  end

  def reset_move_history
    human.move_history = []
    computer.move_history = []
  end

  def reset_round_winner
    human.round_winner = false
    computer.round_winner = false
  end

  def reset_grand_winner
    human.grand_winner = false
    computer.grand_winner = false
  end

  def reset_game
    system "clear"
    reset_round_number
    reset_score
    reset_move
    reset_move_history
    reset_round_winner
    reset_grand_winner
  end

  def reset_round
    @round_number += 1
    reset_round_winner
  end

  def grand_winner?
    human.score >= SCORE_TO_WIN || computer.score >= SCORE_TO_WIN
  end

  def add_move_history
    human.move_history << human.move
    computer.move_history << computer.move
  end

  def determine_round_winner
    if human.move > computer.move
      human.round_winner = true
    elsif human.move < computer.move
      computer.round_winner = true
    end
  end

  def add_score
    if human.round_winner
      human.score += 1
    elsif computer.round_winner
      computer.score += 1
    end
  end

  def process_round
    reset_round
    human.choose
    computer.choose(computer.name)
    add_move_history
    determine_round_winner
    add_score
  end

  def display_round_number
    puts ":: Round #{round_number + 1} ::"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}, and " \
         "#{computer.name} chose #{computer.move}."
  end

  def display_round_winner
    if human.round_winner
      puts "#{human.name} won this round!"
    elsif computer.round_winner
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "- Score -"
    puts "#{human.name}'s Score: #{human.score}, " \
         "#{computer.name}'s Score: #{computer.score}"
  end

  def display_move_history
    puts "- Move History -"
    (0...round_number).each do |round_number|
      human_move = human.move_history[round_number]
      computer_move = computer.move_history[round_number]
      puts "[Round #{round_number + 1}] "\
           "#{human.name}: #{human_move}" \
           "#{Helpable::TICK if human_move > computer_move}, " \
           "#{computer.name}: #{computer_move}" \
           "#{Helpable::TICK if computer_move > human_move}"
    end
  end

  def display_round
    system "clear"
    puts '-' * PAGE_WIDTH
    display_round_number
    display_moves
    display_round_winner
    puts
    display_move_history
    puts
    display_score
    puts '-' * PAGE_WIDTH
  end

  def determine_grand_winner
    if human.score >= SCORE_TO_WIN
      human.grand_winner = true
    elsif computer.score >= SCORE_TO_WIN
      computer.grand_winner = true
    end
  end

  def display_grand_winner
    msg = if human.grand_winner
            "** #{human.name} is the grand winner! **"
          elsif computer.grand_winner
            "** #{computer.name} is the grand winner! **"
          end

    puts
    puts "*" * msg.length
    puts msg
    puts "*" * msg.length
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? [Y/N]"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be Y or N."
    end
    answer.downcase == 'y'
  end
end

RPSGame.new.play
