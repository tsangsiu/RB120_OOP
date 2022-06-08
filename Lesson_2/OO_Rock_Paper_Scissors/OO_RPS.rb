=begin

### Textual Description

Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.

### Extract the major nouns and verbs from the description

Nouns: player, move, rule
Verbs: choose, compare

### Organizing verbs with the nouns

Player
  - choose

Move
Rule

  - compare

=end

class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end
  
  def choose
    
  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)
  
end

### Orchestration Engine

class RPSGame
  attr_accessor :human, :computer
  def initialize
    @human = player.new
    @computer = player.new
  end
  
  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end
