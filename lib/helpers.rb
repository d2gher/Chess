# fronzen_string_literal: true

require 'io/console'
require 'yaml'

def user_input
  $stdin.echo = false
  $stdin.raw!

  input = $stdin.getc.chr

  input << $stdin.read_nonblock(3) if input == "\e" rescue nil 

  exit 0 if ["\u0003", 'q'].include?(input)
  input
ensure
  $stdin.echo = true
  $stdin.cooked!
end

def save_and_exit(curser, pieces)
  game_info = {curser: curser, pieces: pieces}
  yaml = YAML.dump(game_info)

  file = File.new('save_file', 'w+')
  file.puts(yaml)
  file.close
  puts 'Game saved!'.bold

  exit
end

def load_curser
  open('save_file') do |f|
    data = YAML.unsafe_load_file(f)
    return Controller.new(data[:curser].position, data[:curser].selected, data[:curser].player)
  end
  rescue => e
    puts 'Load failed'.bold
    puts e
    exit
end

def load_pieces(pieces = [])
  open('save_file') do |f|
    data = YAML.unsafe_load_file(f)
    data[:pieces].each do |piece|
      pieces << piece.class.new(piece.position, piece.player)
    end
    return pieces
  end
  rescue => e
    puts 'Load failed'.bold
    puts e
    exit
end