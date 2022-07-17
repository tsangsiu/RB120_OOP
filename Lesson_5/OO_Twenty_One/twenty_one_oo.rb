=begin

Twenty-One is a card game consisting of a dealer and a player, where the
participants try to get as close to 21 as possible without going over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, then the
  highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.

=end

module Displayable
  PROMPT = '=>'

  def join_or(arr, join_word = 'or', delimiter = ', ')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{join_word} ")
    else
      "#{arr[0...-1].join(delimiter)}#{delimiter}#{join_word} #{arr[-1]}"
    end
  end

  def prompt(message)
    puts "#{PROMPT} #{message}"
  end

  def loading(message)
    0.upto(3) do |i|
      print "\r#{PROMPT} #{message}#{'.' * i}"
      $stdout.flush
      pause
    end
    print "\n"
  end

  def clear_screen
    system 'clear'
  end

  def pause
    sleep 0 ## 0.8
  end
end

class Participant
  include Displayable

  attr_reader :game, :cards
  attr_accessor :score

  def initialize(game)
    @game = game # participants need to be aware of the game status
    @score = 0
    reset_cards
  end

  def total
    total = cards.map(&:to_num).sum
    number_of_ace = cards.count { |card| card.rank == 'A' }
    until total <= Game::LIMIT || number_of_ace == 0
      total -= 10
      number_of_ace -= 1
    end
    total
  end

  def busted?
    total > Game::LIMIT
  end

  def display_total
    all_unmasked? ? total : '?'
  end

  def win?(other_participant)
    other_participant.busted? || (!busted? && total > other_participant.total)
  end

  def reset_cards
    @cards = []
  end

  private

  def all_unmasked?
    cards.all? { |card| card.masked == false }
  end
end

class Player < Participant
  def move
    loop do
      if hit?
        hit
      else
        stay
        break
      end
      break if busted?
    end
  end

  private

  def hit
    prompt 'You chose to hit!'
    pause
    loading 'Dealing cards'
    game.deck.deal(self, masked: false)
    game.display_info_board
  end

  def stay
    prompt 'You chose to stay!'
    game.dealer_turn = true
    pause
  end

  def hit?
    answer = nil
    loop do
      prompt 'Would you like to [h]it or [s]tay?'
      answer = gets.chomp.strip.downcase
      break if %w(h s hit stay).include?(answer)
      prompt "Sorry, that's not a valid choice."
    end
    %w(h hit).include?(answer)
  end
end

class Dealer < Participant
  def move
    hit until total >= Game::LIMIT - 4
    stay
  end

  private

  def hit
    prompt 'Dealer chose to hit!'
    pause
    loading 'Dealing cards'
    game.deck.deal(self, masked: true)
    game.display_info_board
  end

  def stay
    prompt 'Dealer chose to stay!'
    pause
  end
end

class Deck
  ACE = 'A'
  FACES = ['J', 'Q', 'K']
  RANKS = [('2'..'9').to_a, '10', FACES, ACE].flatten
  SUITS = ['♣', '♦', '♥', '♠']

  def initialize
    @deck = []
    reset
  end

  def reset
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(suit, rank)
      end
    end
    @deck.shuffle!
  end

  def deal(person, masked: true)
    card = masked ? @deck.pop.mask! : @deck.pop.unmask!
    person.cards << card
  end

  def to_s
    @deck.map(&:to_s).to_s
  end
end

class Card
  attr_reader :suit, :rank, :masked

  def initialize(suit, rank, masked: true)
    @suit = suit
    @rank = rank
    @masked = masked
  end

  def to_s
    @masked ? "[ ? ]" : "[#{suit} #{rank}]"
  end

  def to_num
    case rank
    when '2'..'9'            then rank.to_i
    when '10', 'J', 'Q', 'K' then 10
    when 'A'                 then 11
    end
  end

  def mask!
    @masked = true
    self
  end

  def unmask!
    @masked = false
    self
  end
end

class InfoBoard
  include Displayable

  INFO_BOARD_WIDTH = 80

  def initialize(game)
    @game = game
    @player = game.player
    @dealer = game.dealer
  end

  def display
    clear_screen
    puts '-' * INFO_BOARD_WIDTH
    puts
    display_game_info
    display_cards
    display_dealer_turn
    display_round_winner
    display_grand_winner
    puts '-' * INFO_BOARD_WIDTH
    puts
  end

  def display_welcome_message
    clear_screen
    puts '-' * INFO_BOARD_WIDTH
    puts
    puts 'Welcome to Twenty-One!'.center(INFO_BOARD_WIDTH)
    puts
    puts '-' * INFO_BOARD_WIDTH
    puts
    game.prompt_to_continue
  end

  def display_goodbye_message
    clear_screen
    puts '-' * INFO_BOARD_WIDTH
    puts
    puts 'Thanks for playing Twenty-One! Goodbye!'.center(INFO_BOARD_WIDTH)
    puts
    puts '-' * INFO_BOARD_WIDTH
    puts
  end

  private

  attr_reader :game, :player, :dealer

  def display_game_info
    display_round_number
    display_win_condition
    display_player_score
  end

  def display_round_number
    puts "=== Round #{game.round} ==="
    puts
  end

  def display_win_condition
    puts "The first player to win #{Game::SCORE_TO_WIN} rounds " \
         "wins the game!"
  end

  def display_player_score
    puts "Player's score: #{player.score}; " \
         "Dealer's score: #{dealer.score}"
    puts
  end

  def display_cards
    puts "Your cards at hand are #{join_or(game.player.cards, 'and')}, " \
         "for a total of #{game.player.display_total}."
    puts "Dealer's cards at hand are #{join_or(game.dealer.cards, 'and')}, " \
         "for a total of #{game.dealer.display_total}."
    puts
  end

  def display_dealer_turn
    return unless game.dealer_turn && !game.total_revealed?
    puts "It's dealer's turn!"
    puts
  end

  def display_round_winner
    return unless game.total_revealed?
    if dealer.win?(player)
      puts "Dealer won this round!"
    elsif player.win?(dealer)
      puts "You won this round!"
    else
      puts "It's a tie!"
    end
    puts
  end

  def display_grand_winner
    return unless game.grand_winner?
    if player.score >= Game::SCORE_TO_WIN
      puts "** You are the grand winner! **"
    elsif dealer.score >= Game::SCORE_TO_WIN
      puts "Dealer is the grand winner!"
    end
    puts
  end
end

class Game
  include Displayable

  attr_reader :deck, :player, :dealer, :info_board, :round
  attr_accessor :dealer_turn

  LIMIT = 21
  SCORE_TO_WIN = 3 ##

  def initialize
    @round = 0
    @deck = Deck.new
    @player = Player.new(self)
    @dealer = Dealer.new(self)
    @dealer_turn = false
    @info_board = InfoBoard.new(self)
  end

  def start
    display_welcome_message
    main_game
    display_goodbye_message
  end

  def prompt_to_continue
    prompt "Press [enter] to continue"
    gets
  end

  def total_revealed?
    player.display_total.class == Integer &&
      dealer.display_total.class == Integer
  end

  def grand_winner?
    player.score >= SCORE_TO_WIN || dealer.score >= SCORE_TO_WIN
  end

  def display_info_board
    info_board.display
  end

  private

  # game logistics

  def reset_round
    deck.reset
    player.reset_cards
    dealer.reset_cards
    @dealer_turn = false
  end

  def reset_game
    reset_round
    @round = 0
    player.score = 0
    dealer.score = 0
  end

  def main_game
    loop do
      display_info_board
      rounds
      display_info_board
      break unless play_again?
      reset_game
    end
  end

  def rounds
    loop do
      do_preparatory_work
      players_move
      reveal_dealer_cards
      increment_score
      display_info_board
      prompt_to_continue
      break if grand_winner?
    end
  end

  def do_preparatory_work
    reset_round
    increment_round_number
    deal_cards
    display_info_board
  end

  def deal_cards
    deck.deal(player, masked: false)
    deck.deal(dealer, masked: false)
    deck.deal(player, masked: false)
    deck.deal(dealer)
  end

  def players_move
    player_move
    dealer_move unless player.busted?
  end

  def player_move
    player.move
  end

  def dealer_move
    clear_screen
    display_info_board
    pause
    dealer.move
  end

  def reveal_dealer_cards
    display_reveal_cards_message unless player.busted?
    dealer.cards.each(&:unmask!)
  end

  def increment_score
    if dealer.win?(player)
      dealer.score += 1
    elsif player.win?(dealer)
      player.score += 1
    end
  end

  def increment_round_number
    @round += 1
  end

  def play_again?
    answer = nil
    loop do
      prompt 'Would you like to play again [Y/N]?'
      answer = gets.chomp.strip.downcase
      break if %w(y n).include?(answer)
      prompt 'Sorry, it must be Y or N.'
    end
    answer == 'y'
  end

  # display

  def display_reveal_cards_message
    loading "Revealing dealer's cards"
  end

  def display_welcome_message
    info_board.display_welcome_message
  end

  def display_goodbye_message
    info_board.display_goodbye_message
  end
end

Game.new.start
