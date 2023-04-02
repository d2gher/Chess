# fronzen_string_literal: true

# class responsible for the output
class Display
  attr_accessor :empty_board, :message

  @message = "Player's 1 move!"

  def initialize; end

  def self.print_board(board)
    system('clear')
    board.each do |row|
      puts row.join
    end
    puts ''
    puts @message
  end

  def self.message(message)
    @message = message
  end

  def self.announce_winner(winner)
    message = "Player #{winner} has won!!!!"
    sleep 1
    puts ('-' * message.length).to_s
    sleep 1
    puts message
    sleep 1
    puts "#{'-' * message.length}\n"
    sleep 1
  end
end
