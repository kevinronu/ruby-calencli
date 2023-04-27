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

def find_event(id, events)
  finded_event = events.find { |event| event["id"] == id }

  while finded_event.nil?
    puts "Event not found"
    print "Event ID: ".colorize(:light_cyan)
    id = gets.chomp.to_i
    finded_event = events.find { |event| event["id"] == id }
  end
  finded_event
end

def show_hours(event)
  start_hour = event["start_date"][11..15]
  end_hour = event["end_date"][11..15]
  print "Start_end: ".colorize(:light_cyan)
  if end_hour.nil?
    puts "It's an all day event"
  else
    puts "#{start_hour} #{end_hour}"
  end
end

def show_event(event)
  # id = get_input("Event ID", "Cannot be blank").to_i
  # finded_event = find_event(id, events)

  print "Date: ".colorize(:light_cyan)
  puts event["start_date"].split("T")[0]
  print "Title: ".colorize(:light_cyan)
  puts event["title"]
  # puts event["title"].to_s
  print "Calendar: ".colorize(:light_cyan)
  puts event["calendar"]
  # puts event["calendar"].to_s
  show_hours(event)
  print "Notes: ".colorize(:light_cyan)
  puts event["notes"]
  # puts event["notes"].to_s
  print "Guests: ".colorize(:light_cyan)
  puts event["guests"].join(", ")
end

def delete_event(events)
  id = get_input("Event ID", "Cannot be blank").to_i
  finded_event = find_event(id, events)
  events.delete(finded_event)
  puts "Event deleted"
end

def calendar_color(event)
  case event["calendar"]
  when "english"
    :magenta
  when "web-dev"
    :red
  when "soft-skills"
    :green
  when "default"
    :default
  else
    :light_gray
  end
end

# Method that sorts an array of hashes by a value
def sort_array_hashes(array_of_hashes, sort_by)
  array_of_hashes.sort_by! { |hash| hash[sort_by] }
end

def divide_events(events)
  events_without_end_date = []
  events_with_end_date = []
  events.each do |event|
    if event["end_date"] == ""
      events_without_end_date.push(event)
    else
      events_with_end_date.push(event)
    end
  end
  sort_array_hashes(events_with_end_date, "start_date")
  [events_without_end_date, events_with_end_date]
end

def show_events_without_end_date(events)
  events.each_with_index do |event, index|
    color = calendar_color(event)
    if index.zero?
      print "              "
      print "#{event['title']} ".colorize(color)
      puts "(#{event['id']})".colorize(color)
    end
    print "                          "
    print "#{event['title']} ".colorize(color)
    puts "(#{event['id']})".colorize(color)
  end
end

def show_events_with_end_date(events)
  events.each do |event|
    color = calendar_color(event)
    print "            "
    print "#{event['start_date'][11..15]} - #{event['end_date'][11..15]} ".colorize(color)
    print "#{event['title']} ".colorize(color)
    puts "(#{event['id']})".colorize(color)
  end
end

def show_events_when_all_have_end_date(events)
  events.each_with_index do |event, index|
    color = calendar_color(event)
    if index.zero?
      print "#{event['start_date'][11..15]} - #{event['end_date'][11..15]} ".colorize(color)
      print "#{event['title']} ".colorize(color)
      puts "(#{event['id']})".colorize(color)
    end
    print "            "
    print "#{event['start_date'][11..15]} - #{event['end_date'][11..15]} ".colorize(color)
    print "#{event['title']} ".colorize(color)
    puts "(#{event['id']})".colorize(color)
  end
end

def show_day(day, events)
  print "#{day.strftime('%a')} #{day.strftime('%b')} #{day.strftime('%d')}  " # Calendar
  day_events = events.select { |event| day === Date.parse(event["start_date"]) }
  if day_events.empty?
    puts "              No events"
  else
    events_without_end_date = divide_events(day_events)[0]
    events_with_end_date = divide_events(day_events)[1]
    if events_without_end_date.empty?
      show_events_when_all_have_end_date(events_with_end_date)
    else
      show_events_without_end_date(events_without_end_date)
      show_events_with_end_date(events_with_end_date)
    end
  end
  puts ""
end

def show_week(events, date = DateTime.now, msg = "")
  day = date - (date.strftime("%u").to_i - 1) # Lunes de esta fecha
  puts "#{'-' * 29}#{msg}#{'-' * 30}".colorize(:light_cyan)
  puts ""
  7.times do |_number|
    show_day(day, events)
    day += 1
  end
end
