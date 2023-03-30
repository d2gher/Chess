require_relative 'lib/helpers'
require_relative 'lib/board'
require_relative 'lib/display'
require_relative 'lib/controller'
require_relative 'lib/piece'

board = Board.new
curser = Controller.new
pieces = []

pieces << Piece.new([0, 1], 1)
pieces << Piece.new([0, 2], 2)

loop do
  grid = board.build_board(curser, pieces)
  Display.print_board(grid)
  curser.handle_input(pieces)
end
