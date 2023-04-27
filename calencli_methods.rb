# Methods

def check_empty(input, text, msg = "")
  while input.empty?
    puts msg
    print "#{text}: ".colorize(:light_cyan)
    input = gets.chomp
  end
  input
end
