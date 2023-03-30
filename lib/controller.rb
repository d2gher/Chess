# fronzen_string_literal: true

# class for the game controller
class Controller
  attr_accessor :position, :selected

  KEYMAP = {
    ' ' => :space,
    'w' => :up,
    'a' => :left,
    's' => :down,
    'd' => :right,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left
  }.freeze

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }.freeze

  def initialize(pos = [0, 1], selected = nil, player = 1)
    @position = pos
    @selected = selected
    @player = player
  end

  def handle_input(pieces)
    input = user_input
    key = KEYMAP[input]
    update_position(MOVES[key]) if [:left, :right, :up, :down].include?(key)
    select_piece(pieces) if key == :space
  end

  def update_position(move)
    @position[0] = @position[0] + move[0] if (@position[0] + move[0]).between?(0, 7)
    @position[1] = @position[1] + move[1] if (@position[1] + move[1]).between?(0, 7)
  end

  def select_piece(pieces)
    piece = Piece.piece_at(@position, pieces)
    Display.message("Invaild move! select pieces of player #{@player}") if piece.nil? || piece.player != @player
    @selected = piece unless piece.nil? || piece.player != @player
  end
end
