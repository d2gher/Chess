require_relative 'helpers'
require_relative 'board'
require_relative 'display'
require_relative 'controller'
require_relative 'piece'

# Class for starting the game
class Game
  def initialize(curser = Controller.new, pieces = Piece.set)
    @board = Board.new
    @curser = curser
    @pieces = pieces
  end

  def start
    loop do
      grid = @board.build_board(@curser, @pieces)
      Display.print_board(grid)
      Display.announce_winner(Board.winner) if Board.winner
      break if Board.winner

      @curser.handle_input(@pieces)
    end
  end
end
