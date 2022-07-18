class Card
  attr_reader :rank, :suit

  RANKS = (2..10).to_a + ['Jack', 'Queen', 'King', 'Ace']
  SUITS = ['Diamonds', 'Clubs', 'Hearts', 'Spades']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other_card)
    if rank_to_integer != other_card.rank_to_integer
      rank_to_integer <=> other_card.rank_to_integer
    else
      suit_to_integer <=> other_card.suit_to_integer
    end
  end

  def ==(other_card)
    @rank == other_card.rank && @suit == other_card.suit
  end

  protected

  def rank_to_integer
    RANKS.index(@rank) + 2
  end

  def suit_to_integer
    SUITS.index(@suit)
  end
end

cards = [Card.new(2, 'Hearts'),
  Card.new(10, 'Diamonds'),
  Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
  Card.new(4, 'Diamonds'),
  Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
  Card.new('Jack', 'Diamonds'),
  Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
  Card.new(8, 'Clubs'),
  Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8
