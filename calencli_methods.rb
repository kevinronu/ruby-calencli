require "date"
require "colorize"
# Methods

def get_input(prompt, msg = "")
  print "#{prompt}: ".colorize(:light_cyan)
  input = gets.chomp
  while input.empty?
    puts msg
    print "#{prompt}: ".colorize(:light_cyan)
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

def check_start_end(dual_input)
  boolean1 = check_valid_hours(dual_input)
  until boolean1
    puts "Format: 'HH:MM HH:MM' or leave it empty"
    print "start_end: ".colorize(:light_cyan)
    dual_input = gets.chomp
    boolean1 = check_valid_hours(dual_input)
  end
  boolean2 = check_correct_hours(dual_input)
  until boolean2
    puts "Cannot end before start"
    print "start_end: ".colorize(:light_cyan)
    dual_input = gets.chomp
    boolean2 = check_correct_hours(dual_input)
  end
  dual_input
end
