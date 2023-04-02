# fronzen_string_literal: true

# class for the game controller
class Controller
  attr_accessor :position, :selected, :player

  KEYMAP = {
    ' ' => :space,
    'w' => :up,
    'a' => :left,
    's' => :down,
    'd' => :right,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    'k' => :save
  }.freeze

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }.freeze

  def initialize(pos = [0, 0], selected = nil, player = 1)
    @position = pos
    @selected = selected
    @player = player
  end

  def handle_input(pieces)
    input = user_input
    key = KEYMAP[input]
    return update_position(MOVES[key]) if [:left, :right, :up, :down].include?(key)

    save_and_exit(self, pieces) if key == :save

    if !@selected.nil? && key == :space && @selected.piece_moves(pieces).include?(position)
      move_piece(pieces)
    elsif key == :space
      select_piece(pieces)
    end
  end

  def update_position(move)
    @position[0] = @position[0] + move[0] if (@position[0] + move[0]).between?(0, 7)
    @position[1] = @position[1] + move[1] if (@position[1] + move[1]).between?(0, 7)
  end

  def select_piece(pieces)
    piece = Board.piece_at(@position, pieces)
    Display.message("Invaild move! Select pieces of player #{@player}") if piece.nil? || piece.player != @player
    @selected = piece unless piece.nil? || piece.player != @player
  end

  def move_piece(pieces)
    Board.apply_movement(@position, pieces, @selected)
    @player = @player == 1 ? 2 : 1
    @selected = nil

    Display.message('') if Board.winner
    return if Board.winner

    Display.message("Player's #{@player} move!")
  end
end
