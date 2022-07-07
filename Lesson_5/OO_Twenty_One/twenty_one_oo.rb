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

Noun: Dealer, Player, Participant, Card, Deck, Total, Game
Verb: Deal, Hit, Stay, Bust, Win, Lose, Tie

Player
  - hit
  - stay
  - busted?
  - total
Dealer
  - hit
  - stay
  - busted?
  - total
  - deal (?)
Participant
Deck
  - deal (?)
Card
Game
  - start

=end

class Player
  def initialize
    # what would the "data" or "states" of a Player object entail?
    # probably cards
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

class Dealer
  def initialize
    # seems very similar to player
  end
  
  def deal
    # dealer deals or the deck deals?
  end

  def hit
  end
  
  def stay
  end
  
  def busted?
    # total > 21
  end
  
  def total
    # we need to know dealer's cards to calculate the total
  end
end

class Participant
  # probably contains the common behaviors of player and dealer
end

class Deck
  def initialize
  end
  
  def reset
    # probably need to reset between games
  end
  
  def deal
    # the deck deal or the dealer deal?
  end
end

class Card
  def initialize
    # what are the states of the cards?
  end
end

class Game
  def initialize
    # the game needs to know about the deck
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    display_result
  end
end

Game.new.start
