require_relative 'lib/board'
require_relative 'lib/display'
require_relative 'lib/controller'

board = Board.new
curser = Controller.new
display = Display.new

loop do
  grid = board.build_board(curser.position)
  display.print_board(grid)
  curser.handle_input
end
