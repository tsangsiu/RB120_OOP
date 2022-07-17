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
    sleep 0.8
  end
end

class Participant
  include Displayable

  attr_reader :cards

  def initialize(game)
    @game = game # participants need to be aware of the game status
    @cards = []
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

  private

  attr_reader :game

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
    game.dispaly_cards
  end

  def stay
    prompt 'You chose to stay!'
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
    game.dispaly_cards
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

  def deal(person, masked: true)
    card = masked ? @deck.pop.mask! : @deck.pop.unmask!
    person.cards << card
  end

  def to_s
    @deck.map(&:to_s).to_s
  end

  private

  def reset
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(suit, rank)
      end
    end
    @deck.shuffle!
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

class Game
  include Displayable

  attr_reader :deck

  LIMIT = 21

  def initialize
    @deck = Deck.new
    @player = Player.new(self)
    @dealer = Dealer.new(self)
  end

  def start
    do_preparatory_work
    player_turn
    dealer_turn unless player.busted?
    reveal_dealer_cards
    dispaly_cards
    display_result
    prompt_to_continue
    display_goodbye_message
  end

  def dispaly_cards
    clear_screen
    prompt "Your cards at hand are #{join_or(player.cards, 'and')}, " \
           "for a total of #{player.display_total}."
    prompt "Dealer's cards at hand are #{join_or(dealer.cards, 'and')}, " \
           "for a total of #{dealer.display_total}."
    puts
  end

  private

  attr_reader :player, :dealer

  # game logistics

  def do_preparatory_work
    clear_screen
    display_welcome_message
    prompt_to_continue
    deal_cards
    dispaly_cards
  end

  def prompt_to_continue
    prompt "Press [enter] to continue"
    gets
  end

  def deal_cards
    deck.deal(player, masked: false)
    deck.deal(dealer, masked: false)
    deck.deal(player, masked: false)
    deck.deal(dealer)
  end

  def player_turn
    player.move
  end

  def dealer_turn
    clear_screen
    dispaly_cards
    display_dealer_turn
    pause
    dealer.move
  end

  def reveal_dealer_cards
    display_reveal_cards_message unless player.busted?
    dealer.cards.each(&:unmask!)
  end

  # display

  def display_welcome_message
    clear_screen
    prompt 'Welcome to Twenty-One!'
    puts
  end

  def display_dealer_turn
    prompt "It's dealer's turn!"
  end

  def display_reveal_cards_message
    loading "Revealing dealer's cards"
  end

  def display_result
    if dealer.win?(player)
      prompt "Dealer won!"
    elsif player.win?(dealer)
      prompt "**You won!**"
    else
      prompt "It's a tie!"
    end
    pause
  end

  def display_goodbye_message
    clear_screen
    prompt 'Thanks for playing Twenty-One! Goodbye!'
    puts
  end
end

Game.new.start
