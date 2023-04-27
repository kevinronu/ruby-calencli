require "date"
# Methods

def check_empty(input, text, msg = "")
  while input.empty?
    puts msg
    print "#{text}: ".colorize(:light_cyan)
    input = gets.chomp
  end
  input
end

def check_valid_hour(input)
  return true if input.empty? || input.match?(/^(?:[01]\d|2[0-3]):[0-5]\d$/)

  false
end

def check_correct_hours(dual_input)
  return true if dual_input.empty?

  a = dual_input[0..4]
  b = dual_input[6..10]
  # DateTime.strptime('02/22/2018 5:20 PM', '%m/%d/%Y %l:%M %p')
  date1 = DateTime.strptime("2023-04-26 #{a}", "%Y-%m-%d %H:%M")
  date2 = DateTime.strptime("2023-04-26 #{b}", "%Y-%m-%d %H:%M")

  date1 < date2
end
