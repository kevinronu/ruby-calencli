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

def check_valid_hours(dual_input)
  return true if dual_input.empty?

  hour1 = dual_input[0..4]
  hour2 = dual_input[6..10]
  regex = /^(?:[01]\d|2[0-3]):[0-5]\d$/
  hour1.match?(regex) && hour2.match?(regex)
end

def check_start_before_end(dual_input)
  return true if dual_input.empty?

  hour1 = dual_input[0..4]
  hour2 = dual_input[6..10]
  # DateTime.strptime('02/22/2018 5:20 PM', '%m/%d/%Y %l:%M %p')
  date1 = DateTime.strptime("2023-04-26 #{hour1}", "%Y-%m-%d %H:%M")
  date2 = DateTime.strptime("2023-04-26 #{hour2}", "%Y-%m-%d %H:%M")

  date1 < date2
end
