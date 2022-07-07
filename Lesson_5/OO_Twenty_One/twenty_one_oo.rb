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

  def prompt(message)
    puts "=> #{message}"
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
    # total > 21
  end

  def total
    # we need to know player's cards to calculate the total
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
  SUITS = ['Club', 'Diamond', 'Heart', 'Spade']
  WORD_TO_SUIT = { 'Club' => '♣', 'Diamond' => '♦',
                   'Heart' => '♥', 'Spade' => '♠' }

  def initialize
    @deck = []
    reset
  end

  def deal(person, number_of_cards)
    number_of_cards.times { |_| person.cards << @deck.shuffle.pop }
  end

  def to_s
    @deck.map(&:to_s).to_s
  end

  private

  def reset
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(WORD_TO_SUIT[suit], rank)
      end
    end
  end
end

class Card
  def initialize(suit, rank)
    @card = [suit, rank]
  end

  def to_s
    "[#{@card.first}, #{@card.last}]"
  end
end

class Game
  include HelperMethod

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    deal_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # display_result
  end

  private

  attr_reader :deck, :player, :dealer

  def deal_cards
    deck.deal(player, 2)
    deck.deal(dealer, 2)
  end

  def show_initial_cards
    prompt "Your cards at hand are #{join_or(player.cards, ', ', 'and')}"
    prompt "Dealer's cards at hand are #{join_or(dealer.cards, ', ', 'and')}"
  end
end

Game.new.start
