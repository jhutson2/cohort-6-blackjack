class Card
  #value
  #suit
  attr_accessor :value, :suit, :face

  def description
    "The #{face} of #{suit}"
  end
end

class Deck
  # 52 cards (13 of each suit)
  #   2,3,4,5,6,7,8,9,10,J,Q,K,Ace
  # Spade, Club, Heart, Diamond
  # Shuffle
  # Deal
  attr_accessor :cards
  def initialize
    @cards = []

    ["Spades", "Clubs", "Hearts", "Diamonds"].each do |suit|
      faces_and_values = {
        2       => 2,
        3       => 3,
        4       => 4,
        5       => 5,
        6       => 6,
        7       => 7,
        8       => 8,
        9       => 9,
        10      => 10,
        "Jack"  => 10,
        "Queen" => 10,
        "King"  => 10,
        "Ace"   => 11
      }
      faces_and_values.each do |face, value|
        card = Card.new
        card.value = value
        card.suit = suit
        card.face = face
        @cards << card
      end
    end
    @cards.shuffle!
  end

  def deal
    @cards.pop
  end
end

class Hand
  # At least 2 cards(At least 1 is hidden from dealer)
  # value
  # blackjack?
  # bust
  attr_accessor :cards
  def initialize (deck)
    @cards = []
    2.times do
      hit(deck)
    end
  end

  def hit(deck)
    card = deck.deal
    @cards << card
  end

  def description
    @cards.map { |card| card.description }.join(" and ")
  end

  def value
    # Long version of inject
    @cards.inject(0) {|total, card| total + card.value}
    # Short hand version of inject
    @cards.map { |card| card.value }.inject(:+)
    # Without inject
    total = 0
    @cards.each do |card|
      total = total + card.value
    end
    return total
  end

  def blackjack?
    if value == 21
      true
    else
      false
    end
  end
end

class Dealer
  def initialize(deck)
    @hand = Hand.new(deck)
  end

  def card_total
    @hand.value
  end

  def need_card?
    card_total < 16
  end
end

class Player
  def initialize(deck)
      @hand = Hand.new(deck)
  end

  def card_total
    @hand.value
  end
end

  #   if card_total > 21
  #     puts "Bust"
  #   else
  #     if card_total < 16
  #       @hand.hit(deck)
  #     end
  #   end
  # end

deck = Deck.new

p deck.cards.length

player_hand = Hand.new(deck)
p player_hand.description
p player_hand.value
p player_hand.blackjack?

dealer_hand = Hand.new(deck)
p dealer_hand.description
p dealer_hand.value
p dealer_hand.blackjack?

# dealer = Dealer.new(deck)
# dealer.need_card?

# dealer gets two cards
# player gets two cards
# Keep asking player if they want cards
#   until either they bust, they get 21, or they choose to stop
# Dealer keeps taking cards until they go over 16
# decide who wins
#   player wins if more than the dealer but didn't bust, or if the dealer busts
