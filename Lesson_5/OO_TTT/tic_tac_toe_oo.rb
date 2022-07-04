module HelperMethod
  def join_or(arr, delimiter = ', ', join_word = 'or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{join_word} ")
    else
      "#{arr[0...-1].join(delimiter)}#{delimiter}#{join_word} #{arr[-1]}"
    end
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

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def display
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

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
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  include HelperMethod
  attr_reader :board, :human, :computer

  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER
  INFO_BOARD_WIDTH = 40
  SCORE_TO_WIN = 3

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = FIRST_TO_MOVE
  end

  def play
    clear_screen
    display_welcome_message
    prompt_to_continue
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_info_board
      display_board
      loop do
        player_move
        increment_score
        display_info_board
        display_board
        prompt_to_continue
        break if grand_winner?
        board.reset
        clear_screen
        display_info_board
        display_board
      end
      display_info_board
      display_board
      break unless play_again?
      display_play_again_message
      reset
    end
  end

  def prompt_to_continue
    puts "Press [enter] to continue"
    gets
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      if human_turn?
        clear_screen
        display_info_board
        display_board
      end
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_player = COMPUTER_MARKER
    else
      computer_moves
      @current_player = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_player == HUMAN_MARKER
  end

  def human_moves
    puts "Choose a square: #{join_or(board.unmarked_keys)}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.strip.downcase
      break if %w(y n).include?(answer)
      puts 'Sorry, must be y or n'
    end
    answer == 'y'
  end

  def reset
    board.reset
    human.score = 0
    computer.score = 0
    @current_player = FIRST_TO_MOVE
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts
  end

  def display_round_winner
    case board.winning_marker
    when human.marker
      puts '**You won this round!**'
    when computer.marker
      puts 'Computer won this round!'
    else
      puts "It's a tie!"
    end
    puts   
  end

  def grand_winner?
    human.score >= SCORE_TO_WIN || computer.score >= SCORE_TO_WIN
  end

  def display_grand_winner
    if human.score >= SCORE_TO_WIN
      puts '**You are the grand winner!'
    elsif computer.score >= SCORE_TO_WIN
      puts 'Computer is the grand winner!'
    end
    puts
  end

  def increment_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts
  end

  def display_goodbye_message
    clear_screen
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_info_board
    clear_screen
    puts '-' * INFO_BOARD_WIDTH
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts
    if board.someone_won? || board.full?
      display_round_winner
    end
    if grand_winner?
      display_grand_winner
    end
    puts "Your score: #{human.score}; Computer's score: #{computer.score}"
    puts '-' * INFO_BOARD_WIDTH
    puts
  end

  def display_board
    board.display
    puts
  end

  def clear_screen
    system 'clear'
  end
end

game = TTTGame.new
game.play
