require_relative 'lib/helpers'
require_relative 'lib/board'
require_relative 'lib/display'
require_relative 'lib/controller'
require_relative 'lib/piece'

board = Board.new
curser = Controller.new
pieces = []

# pieces << Bishop.new([4, 4], 1)
# pieces << Pawn.new([3, 4], 1)
# pieces << Pawn.new([3, 6], 2)
pieces << Queen.new([3, 6], 1)
pieces << Queen.new([3, 3], 2)
pieces << King.new([3, 1], 1)

loop do
  grid = board.build_board(curser, pieces)
  Display.print_board(grid)
  curser.handle_input(pieces)
end
