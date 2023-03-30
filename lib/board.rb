# fronzen_string_literal: true

require 'colorize'

# class responsible for the board
class Board
  def initialize
    @empty_board = create_empty_board
  end

  def build_board(curser, pieces)
    board = @empty_board.map(&:clone)
    pieces.each do |piece|
      pos1 = piece.position[0]
      pos2 = piece.position[1]
      board[pos1][pos2] = piece.symbol.colorize(background: bg_color(pos1, pos2))
    end
    update_curser(board, curser.position)
    update_seleted(board, curser.selected)
    board
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
    return :black if (row + col).odd?

    :white
  end

  def update_curser(board, curser)
    board[curser[0]][curser[1]] = board[curser[0]][curser[1]].colorize(background: :red)
  end

  def update_seleted(board, selected)
    return if selected.nil?

    pos1 = selected.position[0]
    pos2 = selected.position[1]
    board[pos1][pos2] = board[pos1][pos2].colorize(background: :blue)
  end
end
