# require "date"
# require "colorize"
# Methods

def get_input(prompt:, msg: "", required: true)
  print "#{prompt}: ".colorize(:light_cyan)
  input = gets.chomp
  return input unless required

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
  return false if hour2.nil?

  regex = /^(?:[01]\d|2[0-3]):[0-5]\d$/
  hour1.match?(regex) && hour2.match?(regex)
end

def valid_date(required: true, msg: "")
  print "Date: ".colorize(:light_cyan)
  input = gets.chomp
  # return input if input.empty?

  regex = /^\d{4}-\d{2}-\d{2}$/
  until input.match?(regex) || (input.empty? && !required)
    puts "Type a valid date 'YYYY-MM-DD'#{msg}"
    print "Date: ".colorize(:light_cyan)
    input = gets.chomp
  end
  input
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
  boolean2 = check_start_before_end(dual_input)
  until boolean2
    puts "Cannot end before start"
    print "start_end: ".colorize(:light_cyan)
    dual_input = gets.chomp
    boolean2 = check_start_before_end(dual_input)
  end
  dual_input
end

def find_event(id, events)
  event_found = events.find { |event| event["id"] == id }

  while event_found.nil?
    puts "Event not found"
    print "Event ID: ".colorize(:light_cyan)
    id = gets.chomp.to_i
    event_found = events.find { |event| event["id"] == id }
  end
  event_found
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
  print "Date: ".colorize(:light_cyan)
  puts event["start_date"].split("T")[0]
  print "Title: ".colorize(:light_cyan)
  puts event["title"]
  print "Calendar: ".colorize(:light_cyan)
  puts event["calendar"]
  show_hours(event)
  print "Notes: ".colorize(:light_cyan)
  puts event["notes"]
  print "Guests: ".colorize(:light_cyan)
  puts event["guests"].join(", ")
end

def delete_event(events)
  id = get_input(prompt: "Event ID", msg: "Cannot be blank").to_i
  event_found = find_event(id, events)
  events.delete(event_found)
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
    else
      print "                          "
    end
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
    print "            " unless index.zero?
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
  day = date - (date.strftime("%u").to_i - 1) # Monday of this week
  puts "#{'-' * 29}#{msg}#{'-' * 30}".colorize(:light_cyan)
  puts ""
  7.times do |_number|
    show_day(day, events)
    day += 1
  end
end

def valid_empty(input, event, key)
  input.empty? ? event[key] : input
end

def update_events(events, id)
  event = find_event(id, events)

  date = valid_date(required: false, msg: " or leave it empty")
  date = date.empty? ? event["start_date"][0..9] : date

  title = get_input(prompt: "Title", required: false)
  title = valid_empty(title, event, "title")

  calendar = get_input(prompt: "Calendar", required: false)
  calendar = valid_empty(calendar, event, "calendar")

  start_end = get_input(prompt: "start_end", required: false)
  start_end = check_start_end(start_end)

  start_date = "#{date}T#{start_end[0..4]}:00-05:00"
  end_date = "#{date}T#{start_end[6..10]}:00-05:00"
  if start_end.empty?
    start_date = "#{date}T#00:00:00-05:00"
    end_date = ""
  end

  notes = get_input(prompt: "Notes", required: false)
  notes = valid_empty(notes, event, "notes")

  guests = get_input(prompt: "Guests", required: false).split(", ")
  guests = valid_empty(guests, event, "guests")

  hash = { "start_date" => start_date,
           "title" => title, "end_date" => end_date,
           "notes" => notes, "guests" => guests,
           "calendar" => calendar }

  event.merge!(hash)
  events[events.index(event)].merge!(event)
end

def create_event(events, id)
  date = valid_date(required: true)

  title = get_input(prompt: "Title", msg: "Cannot be blank", required: true)

  calendar = get_input(prompt: "Calendar", required: false)

  start_end = get_input(prompt: "start_end", required: false)
  start_end = check_start_end(start_end)

  start_date = "#{date}T#{start_end[0..4]}:00-05:00"
  end_date = "#{date}T#{start_end[6..10]}:00-05:00"
  if start_end.empty?
    start_date = "#{date}T#00:00:00-05:00"
    end_date = ""
  end

  notes = get_input(prompt: "Notes", required: false)

  guests = get_input(prompt: "Guests", required: false).split(", ")

  hash = { "id" => id,
           "start_date" => start_date,
           "title" => title, "end_date" => end_date,
           "notes" => notes, "guests" => guests,
           "calendar" => calendar }

  events << hash
end
