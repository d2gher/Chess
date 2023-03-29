# fronzen_string_literal: true

require_relative 'helpers'

# class for the game controller
class Controller
  attr_accessor :position

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

  def initialize(pos = [0, 0])
    @position = pos
  end

  def handle_input
    input = user_input
    key = KEYMAP[input]
    update_position(MOVES[key]) if [:left, :right, :up, :down].include?(key)
  end

  def update_position(move)
    @position[0] = @position[0] + move[0] if (@position[0] + move[0]).between?(0, 7)
    @position[1] = @position[1] + move[1] if (@position[1] + move[1]).between?(0, 7)
  end
end
