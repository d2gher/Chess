# fronzen_string_literal: true

# class responsible for the output
class Display
  attr_accessor :empty_board

  def initialize; end

  def print_board(board)
    # system('clear')
    board.each do |row|
      puts row.join
    end
  end
end
