# fronzen_string_literal: true

require 'colorize'

# class responsible for the board
class Board
  @winner = nil

  def initialize
    @empty_board = create_empty_board
  end

  def build_board(curser, pieces)
    board = @empty_board.map(&:clone)
    add_pieces(board, pieces)
    update_seleted(board, curser.selected, pieces)
    update_curser(board, curser.position)
    board
  end

  def self.piece_at(position, pieces)
    pieces.each do |piece|
      return piece if piece.position == position
    end
    nil
  end

  def self.apply_movement(position, pieces, piece)
    piece.first_move = false if piece.is_a?(Pawn)
    target = piece_at(position, pieces)

    @winner = piece.player if target.is_a?(King)

    pieces.delete(target) unless target.nil?

    piece.position[0] = position[0]
    piece.position[1] = position[1]
  end

  def self.winner
    @winner
  end
  
  private

  def create_empty_board
    grid = []
    8.times do |i|
      grid[i] = []
      8.times do |j|
        grid[i][j] = '   '.colorize(background: bg_color(i, j))
      end
    end
    grid
  end

  def bg_color(row, col)
    return :default if (row + col).odd?

    :black
  end

  def update_curser(board, curser)
    board[curser[0]][curser[1]] = board[curser[0]][curser[1]].colorize(background: :red)
  end

  def update_seleted(board, selected, pieces)
    return if selected.nil?

    pos1 = selected.position[0]
    pos2 = selected.position[1]
    board[pos1][pos2] = board[pos1][pos2].colorize(background: :blue)

    moves = selected.piece_moves(pieces)
    moves.each do |move|
      board[move[0]][move[1]] = board[move[0]][move[1]].colorize(background: :green)
    end
  end

  def add_pieces(board, pieces)
    pieces.each do |piece|
      pos1 = piece.position[0]
      pos2 = piece.position[1]
      board[pos1][pos2] = piece.symbol.colorize(background: bg_color(pos1, pos2))
    end
  end
end
