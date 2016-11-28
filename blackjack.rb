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
      [2,3,4,5,6,7,8,9,10].each do |value|
        card = Card.new
        card.value = value
        card.suit = suit
        card.face = value
        @cards << card
      end
      ["Jack", "Queen", "King"].each do |face|
        card = Card.new
        card.value = 10
        card.suit = suit
        card.face = face
        @cards << card
      end
      ["Ace"].each do |face|
        card = Card.new
        card.value = 11
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
      card = deck.deal
      @cards << card
    end
  end

  def description
    @cards.map {|card| card.description}.join(" and ")
  end

  def value
    # Long version of inject
    @cards.inject(0) {|total, card| total + card.value}
    # Short hand version of inject
    @cards.map {|card| card.value}.inject(:+)
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
