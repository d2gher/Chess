# fronzen_string_literal: true

# class responsible for the output
class Display
  attr_accessor :empty_board, :message

  @message = "Player's 1 move!"

  def initialize; end

  def self.print_board(board)
    system('clear')
    puts "#{'Controls:'.bold} \nUse [AWDS] or arrow keys to move,\n[space] to select, [q] to quit, and [k] to save"
    puts ''
    board.each do |row|
      print '|'
      print row.join
      puts '|'
    end
    puts ''
    puts @message
  end

  def self.message(message)
    @message = message
  end

  def self.announce_winner(winner)
    message = "Player #{winner} has won!!!!".bold.green
    sleep 1
    puts ('-' * "Player #{winner} has won!!!!".length).to_s
    sleep 1
    puts message
    sleep 1
    puts "#{'-' * "Player #{winner} has won!!!!".length}\n"
    sleep 1
  end

  def self.start_screen
    system('clear')
    puts title
    puts "
#{'1. New game'.bold}
#{'2. Load saved game'.bold}
    "
  end

  def self.title
    "
▄████████    ▄█    █▄       ▄████████    ▄████████    ▄████████
███    ███   ███    ███     ███    ███   ███    ███   ███    ███
███    █▀    ███    ███     ███    █▀    ███    █▀    ███    █▀
███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄       ███          ███
███        ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀     ▀███████████ ▀███████████
███    █▄    ███    ███     ███    █▄           ███          ███
███    ███   ███    ███     ███    ███    ▄█    ███    ▄█    ███
████████▀    ███    █▀      ██████████  ▄████████▀   ▄████████▀
    "
  end
end
