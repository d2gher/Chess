require_relative 'lib/game'

Display.start_screen
loop do
  option = 0
  option = gets.chomp.to_i until [1, 2].include?(option)

  # New game
  game = Game.new if option == 1

  # Load game
  if option == 2
    curser = load_curser
    pieces = load_pieces

    game = Game.new(curser, pieces)
  end

  game.start
end
