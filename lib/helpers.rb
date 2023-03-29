# fronzen_string_literal: true

require "io/console"

def user_input
  $stdin.echo = false
  $stdin.raw!

  input = $stdin.getc.chr

  input << STDIN.read_nonblock(3) if input == "\e" rescue nil 

  exit 0 if ["\u0003", 'q'].include?(input)
  input
ensure
  $stdin.echo = true
  $stdin.cooked!
end
