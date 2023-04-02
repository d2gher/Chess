# fronzen_string_literal: true

# Class for chess pieces
class Piece
  attr_accessor :symbol, :position, :player

  def initialize; end

  def piece_color(player)
    return :white if player == 1

    :light_black
  end

  def valid_move?(dest, pieces, player)
    in_bound = dest[0].between?(0, 7) && dest[1].between?(0, 7) ? true : false
    occupier = Board.piece_at(dest, pieces)
    occupied = false
    unless occupier.nil?
      occupied = true if occupier.player == player
    end
    return true if in_bound && !occupied

    false
  end

  def sliding(pieces, directions, player, position)
    possible_moves = []
    directions.each do |dir|
      x, y = position
      movex, movey = dir
      dest = [movex + x, movey + y]

      while valid_move?(dest, pieces, player)
        possible_moves << dest
        break if Board.piece_at(dest, pieces)

        dest = [dest[0] + movex, dest[1] + movey]
      end
    end
    possible_moves
  end

  def self.set
    pieces = []
    8.times do |row|
      8.times do |col|
        pieces << Pawn.new([row, col], 1) if row == 6
        pieces << Pawn.new([row, col], 2) if row == 1
        if row == 7
          pieces << Rook.new([row, col], 1) if [0, 7].include?(col)
          pieces << Knight.new([row, col], 1) if [1, 6].include?(col)
          pieces << Bishop.new([row, col], 1) if [2, 5].include?(col)
          pieces << Queen.new([row, col], 1) if col == 3
          pieces << King.new([row, col], 1) if col == 4
        end
        if row.zero?
          pieces << Rook.new([row, col], 2) if [0, 7].include?(col)
          pieces << Knight.new([row, col], 2) if [1, 6].include?(col)
          pieces << Bishop.new([row, col], 2) if [2, 5].include?(col)
          pieces << Queen.new([row, col], 2) if col == 3
          pieces << King.new([row, col], 2) if col == 4
        end
      end
    end
    pieces
  end
end

# child class for Knight piece
class Knight < Piece
  MOVES = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]].freeze

  def initialize(pos, player)
    @symbol = ' ♞ '.colorize(color: piece_color(player))
    @position = pos
    @player = player
  end

  def piece_moves(pieces)
    possible_moves = []
    MOVES.each do |move|
      dest = [@position[0] + move[0], @position[1] + move[1]]
      possible_moves << dest if valid_move?(dest, pieces, @player)
    end
    possible_moves
  end
end

# child class for Pawn piece
class Pawn < Piece
  attr_accessor :first_move

  def initialize(pos, player)
    @symbol = ' ♟︎ '.colorize(color: piece_color(player))
    @position = pos
    @player = player
    @first_move = true
  end

  def piece_moves(pieces)
    moves = [[-1, 0], [-2, 0], [-1, 1], [-1, -1]] if player == 1
    moves = [[1, 0], [2, 0], [1, 1], [1, -1]] if player == 2
    possible_moves = []

    first_move(pieces, moves, possible_moves)
    second_move(pieces, moves, possible_moves)
    diagonal_moves(pieces, moves, possible_moves)

    possible_moves
  end

  def first_move(pieces, moves, possible_moves)
    dest = [@position[0] + moves[0][0], @position[1] + moves[0][1]]
    possible_moves << dest if valid_move?(dest, pieces, @player) && Board.piece_at(dest, pieces).nil?
  end

  def second_move(pieces, moves, possible_moves)
    dest = [@position[0] + moves[1][0], @position[1] + moves[1][1]]
    possible_moves << dest if valid_move?(dest, pieces, @player) && @first_move &&
                              !possible_moves.empty? && Board.piece_at(dest, pieces).nil?
  end

  def diagonal_moves(pieces, moves, possible_moves)
    dest = [@position[0] + moves[2][0], @position[1] + moves[2][1]]
    possible_moves << dest if valid_move?(dest, pieces, @player) && !Board.piece_at(dest, pieces).nil?

    dest = [@position[0] + moves[3][0], @position[1] + moves[3][1]]
    possible_moves << dest if valid_move?(dest, pieces, @player) && !Board.piece_at(dest, pieces).nil?
  end
end

# child class for Rook piece
class Rook < Piece
  DIRECIONS = [[1, 0], [-1, 0], [0, -1], [0, 1]].freeze

  def initialize(pos, player)
    @symbol = ' ♜ '.colorize(color: piece_color(player))
    @position = pos
    @player = player
  end

  def piece_moves(pieces)
    sliding(pieces, DIRECIONS, @player, @position)
  end
end

# child class for Bishop piece
class Bishop < Piece
  DIRECIONS = [[1, 1], [-1, 1], [1, -1], [-1, -1]].freeze

  def initialize(pos, player)
    @symbol = ' ♝ '.colorize(color: piece_color(player))
    @position = pos
    @player = player
  end

  def piece_moves(pieces)
    sliding(pieces, DIRECIONS, @player, @position)
  end
end

# child class for Queen piece
class Queen < Piece
  DIRECIONS = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, -1], [0, 1]].freeze

  def initialize(pos, player)
    @symbol = ' ♛ '.colorize(color: piece_color(player))
    @position = pos
    @player = player
  end

  def piece_moves(pieces)
    sliding(pieces, DIRECIONS, @player, @position)
  end
end

# child class for Queen piece
class King < Piece
  MOVES = [[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]].freeze

  def initialize(pos, player)
    @symbol = ' ♚ '.colorize(color: piece_color(player))
    @position = pos
    @player = player
  end

  def piece_moves(pieces)
    possible_moves = []
    MOVES.each do |move|
      dest = [@position[0] + move[0], @position[1] + move[1]]
      possible_moves << dest if valid_move?(dest, pieces, @player)
    end
    possible_moves
  end
end
