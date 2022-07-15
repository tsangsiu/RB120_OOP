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
    puts "=> #{message}"
  end

  def clear_screen
    system 'clear'
  end
end

class Participant
  attr_reader :cards

  def initialize
    @cards = []
  end

  def hit
    # should know about what cards are left in the deck
  end

  def stay
  end

  def busted?
    total > 21
  end

  def total
    total = @cards.map(&:to_num).sum
    number_of_ace = @cards.count { |card| card.rank == 'A' }
    until total <= 21 || number_of_ace == 0
      total -= 10
      number_of_ace -= 1
    end
    total
  end
end

class Player < Participant
end

class Dealer < Participant
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

  def deal(person, number_of_cards = 1)
    number_of_cards.times { |_| person.cards << @deck.pop }
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
  def initialize(suit, rank, mask = false)
    @card = { suit: suit, rank: rank, mask: mask }
  end

  def to_s
    @card[:mask] ? "[ ? ]" : "[#{@card[:suit]} #{@card[:rank]}]"
  end

  def rank
    @card[:rank]
  end

  def to_num
    case rank
    when '2'..'9'            then rank.to_i
    when '10', 'J', 'Q', 'K' then 10
    when 'A'                 then 11
    end
  end

  def mask
    @card[:mask] = true
  end
end

class Game
  include Displayable

  INFO_BOARD_WIDTH = 50

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    clear_screen
    display_welcome_message
    prompt_to_continue
    deal_cards
    show_cards
    # player_turn
    # dealer_turn
    # show_initial_cards
    # display_result
    # prompt_to_continue
    # display_goodbye_message
  end

  private

  attr_reader :deck, :player, :dealer

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

  def player_turn
    loop do
      if hit?
        prompt "You chose to hit!"
        deck.deal(player)
        show_initial_cards
        prompt "Total = #{player.total}"
      else
        prompt "You chose to stay!"
        break
      end
      break if player.busted?
    end
  end

  def dealer_turn
    deck.deal(dealer) until dealer.total >= 17
  end

  def display_result
    if player.busted?
      prompt "Dealer won!"
    elsif dealer.busted?
      prompt "You won!"
    elsif player.total > dealer.total
      prompt "You won!"
    elsif dealer.total > player.total
      prompt "Dealer won!"
    else
      prompt "It's a tie!"
    end
  end

  def display_goodbye_message
    clear_screen
    prompt 'Thanks for playing Twenty-One! Goodbye!'
    puts
  end
  
  # game logistics

  def prompt_to_continue
    prompt "Press [enter] to continue"
    gets
  end

  def deal_cards
    2.times do
      deck.deal(player)
      deck.deal(dealer)
    end
  end

  def show_cards
    prompt "Your cards at hand are #{join_or(player.cards, 'and')}, " \
           "with a total of #{player.total}."
    prompt "Dealer's cards at hand are #{join_or(mask(dealer.cards), 'and')}."
  end

  # display, not for the info board

  def display_welcome_message
    clear_screen
    puts '-' * INFO_BOARD_WIDTH
    puts
    puts 'Welcome to Twenty-One!'.center(INFO_BOARD_WIDTH)
    puts
    puts '-' * INFO_BOARD_WIDTH
    puts
  end

  private

  def mask(cards)
    cards.each.with_index do |card, index|
      card.mask if index != 0
    end
  end
end

Game.new.start
