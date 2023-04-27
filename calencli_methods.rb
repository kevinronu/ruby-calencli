# Methods

def check_empty(input, text, msg = "")
  while input.empty?
    puts msg
    print "#{text}: ".colorize(:light_cyan)
    input = gets.chomp
  end
  input
end

def check_valid_hour(new_input)
  return true if new_input.empty? || new_input.match?(/^(?:[01]\d|2[0-3]):[0-5]\d$/)

  false
end
