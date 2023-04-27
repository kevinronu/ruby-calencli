require "date"
require "colorize"
require "colorized_string"
require_relative "calencli_methods"

# DATA
id = 0
events = [
  { "id" => (id = id.next),
    "start_date" => "2023-04-13T00:00:00-05:00",
    "title" => "Ruby Basics 1",
    "end_date" => "",
    "notes" => "Ruby Basics 1 notes",
    "guests" => ["Paulo", "Andre"],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-13T09:00:00-05:00",
    "title" => "English Course",
    "end_date" => "2023-04-13T10:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-14T00:00:00-05:00",
    "title" => "Ruby Basics 2",
    "end_date" => "",
    "notes" => "Ruby Basics 2 notes",
    "guests" => ["Paulo", "Andre"],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-14T12:00:00-05:00",
    "title" => "Soft Skills - Mindsets",
    "end_date" => "2023-04-14T13:30:00-05:00",
    "notes" => "Some extra notes",
    "guests" => ["Mili"],
    "calendar" => "soft-skills" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-15T00:00:00-05:00",
    "title" => "Ruby Methods",
    "end_date" => "",
    "notes" => "Ruby Methods notes",
    "guests" => ["Paulo", "Andre"],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-15T09:00:00-05:00",
    "title" => "English Course",
    "end_date" => "2023-04-15T10:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-16T09:00:00-05:00",
    "title" => "Summary Workshop",
    "end_date" => "2023-04-16T13:30:00-05:00",
    "notes" => "A lot of notes",
    "guests" => ["Paulo", "Andre", "Diego"],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-16T00:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-17T09:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-17T09:00:00-05:00",
    "title" => "English Course",
    "end_date" => "2023-04-17T10:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-18T10:00:00-05:00",
    "title" => "Breakfast with my family",
    "end_date" => "2023-04-18T11:00:00-05:00",
    "notes" => "",
    "guests" => [],
    "calendar" => "default" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-18T15:00:00-05:00",
    "title" => "Study",
    "end_date" => "2023-04-18T20:00:00-05:00",
    "notes" => "",
    "guests" => [],
    "calendar" => "default" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-23T00:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-04-24T09:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" }
]

# Main Program

now_date = DateTime.now

$menu = "#{'-' * 78} \nlist | create | show | update | delete | next | prev | exit\n"

show_week(events, now_date, "Welcome to CalenCLI")
print $menu.colorize(:light_cyan)

action = nil
while action != "exit"
  print "\naction: ".colorize(:light_yellow)
  action = gets.chomp
  case action
  when "list"
    show_week(events, now_date, "Welcome to CalenCLI")
    print $menu.colorize(:light_cyan)
  when "create"
    "create_method"
  when "show"
    show(events)
  when "update"
    "update_method"
  when "delete"
    delete_event(events)
  when "next"
    show_week(events, now_date + 7, "------CalenCLI-----")
    now_date += 7
    print $menu.colorize(:light_cyan)
  when "prev"
    show_week(events, now_date - 7, "------CalenCLI-----")
    now_date -= 7
    print $menu.colorize(:light_cyan)
  when "exit"
    puts "\nThanks for using calenCLI".colorize(:light_blue)
  else
    puts "Invalid action".colorize(:light_white)
  end
end
