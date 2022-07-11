module Displayable
  def join_or(arr, delimiter = ', ', join_word = 'or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{join_word} ")
    else
      "#{arr[0...-1].join(delimiter)}#{delimiter}#{join_word} #{arr[-1]}"
    end
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def clear_screen
    system 'clear'
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def [](key)
    @squares[key]
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def count_marker(*keys, marker)
    keys.count { |key| @squares[key].marker == marker }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def display
    puts '     |     |               |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}       " \
         "  #{@squares[7].marked? ? ' ' : '7'}  |" \
         "  #{@squares[8].marked? ? ' ' : '8'}  |" \
         "  #{@squares[9].marked? ? ' ' : '9'}"
    puts '     |     |               |     |'
    puts '-----+-----+-----     -----+-----+-----'
    puts '     |     |               |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}       " \
         "  #{@squares[4].marked? ? ' ' : '4'}  |" \
         "  #{@squares[5].marked? ? ' ' : '5'}  |" \
         "  #{@squares[6].marked? ? ' ' : '6'}"
    puts '     |     |               |     |'
    puts '-----+-----+-----     -----+-----+-----'
    puts '     |     |               |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}       " \
         "  #{@squares[1].marked? ? ' ' : '1'}  |" \
         "  #{@squares[2].marked? ? ' ' : '2'}  |" \
         "  #{@squares[3].marked? ? ' ' : '3'}"
    puts '     |     |               |     |'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  attr_accessor :marker

  INITIAL_MARKER = ' '

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    !marked?
  end
end

class Player
  include Displayable

  attr_reader :marker
  attr_accessor :score, :name

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def marker=(marker)
    @marker = marker[0]
  end
end

class InfoBoard
  include Displayable

  INFO_BOARD_WIDTH = 50

  def initialize(game)
    @game = game
    @board = game.board
    @human = game.human
    @computer = game.computer
  end

  def display_welcome_message
    clear_screen
    puts '-' * INFO_BOARD_WIDTH
    puts
    puts 'Welcome to Tic Tac Toe!'.center(INFO_BOARD_WIDTH)
    puts
    puts '-' * INFO_BOARD_WIDTH
    puts
  end

  def display
    clear_screen
    puts '-' * INFO_BOARD_WIDTH
    puts
    display_round_number
    display_player_marker
    display_win_condition
    display_player_score
    display_winner
    puts '-' * INFO_BOARD_WIDTH
    puts
  end

  private

  attr_reader :game, :board, :human, :computer

  def display_round_number
    puts "=== Round #{game.round} ==="
    puts
  end

  def display_player_marker
    puts "#{human.name}'s marker is '#{human.marker}'. " \
         "#{computer.name}'s marker is '#{computer.marker}'."
    puts
  end

  def display_win_condition
    puts "The first player to win #{TTTGame::SCORE_TO_WIN} rounds " \
         "wins the game!"
    puts
  end

  def display_player_score
    puts "#{human.name}'s score: #{human.score}; " \
         "#{computer.name}'s score: #{computer.score}"
    puts
  end

  def display_winner
    display_round_winner if board.someone_won? || board.full?
    display_grand_winner if game.grand_winner?
  end

  def display_round_winner
    case board.winning_marker
    when human.marker
      puts "** #{human.name} won this round! **"
    when computer.marker
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
    end
    puts
  end

  def display_grand_winner
    if human.score >= TTTGame::SCORE_TO_WIN
      puts "** #{human.name} are the grand winner! **"
    elsif computer.score >= TTTGame::SCORE_TO_WIN
      puts "#{computer.name} is the grand winner!"
    end
    puts
  end
end

class TTTGame
  include Displayable
  attr_reader :board, :human, :computer, :round

  HUMAN_MARKER_DEFAULT = 'O'
  COMPUTER_MARKER = 'X'

  SCORE_TO_WIN = 5
  COMPUTER_NAMES = ['Whale', 'Anahit', 'Curio', 'Mastermind', 'Gorilla',
                    'Pinnacle', 'Optimum', 'Anaconda', 'Freyr', 'Theropod']

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER_DEFAULT)
    @computer = Player.new(COMPUTER_MARKER)
    @round = 1
    @info_board = InfoBoard.new(self)
  end

  def play
    clear_screen
    display_welcome_message
    prompt_to_continue
    do_preparatory_work
    main_game
    display_goodbye_message
  end

  def grand_winner?
    human.score >= SCORE_TO_WIN || computer.score >= SCORE_TO_WIN
  end

  private

  attr_reader :info_board

  # game logistics

  def prompt_to_continue
    prompt "Press [enter] to continue."
    gets
  end

  def do_preparatory_work
    clear_screen
    ask_player_name
    greet_player
    determine_computer_name
    display_computer_name
    choose_marker
    choose_and_determine_first_player
  end

  def main_game
    loop do
      display_info_and_board
      rounds
      display_info_and_board
      break unless play_again?
      reset_game
    end
  end

  def rounds
    loop do
      player_move # loop until the board is full or someone wins
      increment_score
      display_info_and_board
      prompt_to_continue
      break if grand_winner?
      reset_round
    end
  end

  def reset_round
    reset_board
    increment_round_number
    alternate_round_first_player
    display_info_and_board
  end

  def reset_board
    board.reset
  end

  def reset_game
    reset_board
    human.score = 0
    computer.score = 0
    @round = 1
    @current_player = choose_and_determine_first_player
  end

  def increment_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def increment_round_number
    @round += 1
  end

  # for player's response

  def ask_player_name
    prompt "What is your name?"
    loop do
      human.name = gets.chomp.strip
      break unless human.name.empty?
      prompt "Please enter a name."
    end
  end

  def choose_marker
    prompt "Please choose your marker by inputting a single character:"
    prompt "Or you can choose to use the defaut one by pressing [enter]."
    loop do
      marker = gets.chomp.strip
      if accepted_markers?(marker)
        human.marker = marker.length == 1 ? marker : HUMAN_MARKER_DEFAULT
        break
      end
      display_message_for_unaccepted_markers(marker)
    end
  end

  def accepted_markers?(marker)
    marker.length <= 1 && marker != computer.marker
  end

  def choose_first_player
    prompt "Who would you like to go first?"
    prompt "Please choose [m]e, [o]pponent, or [r]andom:"
    loop do
      @round_first_player = gets.chomp.strip.downcase
      break if %w(m o r me opponent random).include?(@round_first_player)
      prompt "Sorry, that's not a valid choice."
    end
  end

  def human_moves
    prompt "Choose a square: #{join_or(board.unmarked_keys)}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      prompt "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def play_again?
    answer = nil
    loop do
      prompt 'Would you like to play again [Y/N]?'
      answer = gets.chomp.strip.upcase
      break if %w(Y N).include?(answer)
      prompt 'Sorry, it must be Y or N.'
    end
    answer == 'Y'
  end

  # computer

  def determine_computer_name
    computer.name = COMPUTER_NAMES.sample
  end

  def computer_moves
    square ||= square_at_risk(:offense)
    square ||= square_at_risk(:defense)
    square = 5 if square.nil? && board[5].unmarked?
    square ||= board.unmarked_keys.sample
    board[square].marker = computer.marker
  end

  def square_at_risk(move)
    square = nil
    marker = move == :offense ? computer.marker : human.marker
    Board::WINNING_LINES.each do |line|
      if at_risk?(*line, marker)
        square = line.select { |key| board[key].unmarked? }.first
        break
      end
    end
    square
  end

  def at_risk?(*line, marker)
    board.count_marker(*line, marker) == 2 &&
      board.count_marker(*line, Square::INITIAL_MARKER) == 1
  end

  # player management

  def alternate_player
    @current_player = human_turn? ? computer.marker : human.marker
  end

  def choose_and_determine_first_player
    choose_first_player
    determine_first_player
  end

  def determine_first_player
    @round_first_player = case @round_first_player
                          when 'm', 'me'
                            human.marker
                          when 'o', 'opponent'
                            computer.marker
                          else
                            [human.marker, computer.marker].sample
                          end
    @current_player = @round_first_player
  end

  def alternate_round_first_player
    @round_first_player = if @round_first_player == human.marker
                            computer.marker
                          else
                            human.marker
                          end
    @current_player = @round_first_player
  end

  def player_move
    loop do
      current_player_moves
      alternate_player
      break if board.someone_won? || board.full?
      display_info_and_board if human_turn?
    end
  end

  def current_player_moves
    human_turn? ? human_moves : computer_moves
  end

  def human_turn?
    @current_player == human.marker
  end

  # display, not for the info board

  def display_welcome_message
    info_board.display_welcome_message
  end

  def greet_player
    prompt "Hi, #{human.name}!"
  end

  def display_computer_name
    prompt "Your opponent's name is #{computer.name}."
  end

  def display_message_for_unaccepted_markers(marker)
    if marker == computer.marker
      prompt "Sorry, that's computer's marker."
    elsif marker.length != 1
      prompt "Sorry, please enter a single character."
    end
  end

  def display_info_board
    info_board.display
    puts
  end

  def display_board
    board.display
    puts
  end

  def display_info_and_board
    display_info_board
    display_board
  end

  def display_goodbye_message
    clear_screen
    prompt 'Thanks for playing Tic Tac Toe! Goodbye!'
    puts
  end
end

game = TTTGame.new
game.play
