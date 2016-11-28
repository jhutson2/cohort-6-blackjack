class Card
  #value
  #suit
  attr_accessor :value, :suit, :face
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

deck = Deck.new

p deck.cards.length

card = deck.deal

puts "The #{card.face} of #{card.suit}"

p deck.cards.length
