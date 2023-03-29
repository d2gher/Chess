# fronzen_string_literal: true

require 'colorize'

# class responsible for the board
class Board

  def initialize
    @empty_board = create_empty_board
  end

  def build_board(curser)
    board = @empty_board.map(&:clone)
    board[curser[0]][curser[1]] = board[curser[0]][curser[1]].colorize(background: :blue)
    board[1][1] = ' ♟︎ '
    board
  end

  private

  def create_empty_board
    grid = []
    8.times do |i|
      grid[i] = []
      8.times do |j|
        grid[i][j] = (i + j).odd? ?
        '   '.colorize(background: :black) :
        '   '.colorize(background: :white)
      end
    end
    grid
  end
end
