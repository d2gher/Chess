# fronzen_string_literal: true

# Class for chess pieces
class Piece
  attr_accessor :symbol, :position, :player

  def initialize(pos, player)
    @symbol = ' ♞ '.colorize(color: piece_color(player))
    @position = pos
    @player = player
  end

  def piece_color(player)
    return :yellow if player == 1

    :red
  end

  def self.piece_at(position, pieces)
    pieces.each do |piece|
      return piece if piece.position == position
    end
    nil
  end
end
