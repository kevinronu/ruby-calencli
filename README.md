# CalenCLI: Your Command-Line Calendar

Welcome to **CalenCLI**, your ultimate command-line calendar experience! With this powerful tool, you can manage your events, appointments, and tasks seamlessly right from your terminal.

## Screenshot

![CalenCLI Screenshot](https://raw.githubusercontent.com/kevinronu/ruby-calencli/main/screenshot.webp)

## Overview

CalenCLI empowers you to stay organized and efficient by offering the following features:

- **Event Management**: Easily create, update, and delete events with all the necessary details.
- **Time Tracking**: Keep track of your schedule by specifying event timings.
- **Categorization**: Label events with categories for better organization.
- **Guest List**: Maintain a list of guests associated with each event.
- **Navigation**: Navigate through your calendar week by week.
- **User-Friendly Interface**: Intuitive command-line interface designed for simplicity and efficiency.

## Getting Started

To harness the power of CalenCLI, follow these simple steps:

1. **Clone the Repository**: Get started by cloning the repository to your local machine:

   ```shell
   git clone git@github.com:kevinronu/ruby-calencli.git
   cd ruby-calencli
   ```

2. **Check Your Ruby Version**: Ensure you have the correct Ruby version installed:

   ```shell
   ruby -v
   ```

   If you don't have the right version, no worries. You can install it using [rbenv](https://github.com/rbenv/rbenv):

   ```shell
   rbenv install 3.1.4
   ```

3. **Install Dependencies**: Run the following command to install the necessary dependencies:

   ```shell
   bundle install
   ```

4. **Run CalenCLI**: Launch the CalenCLI application and start managing your schedule:

   ```shell
   ruby calencli.rb
   ```

## CalenCLI Usage

CalenCLI is a command-line tool that helps you manage your calendar using a range of commands. Below are the available commands and their functionalities:

- `list`: Display the events scheduled for the current week.
- `create`: Create a new event and provide its details.
- `show`: View detailed information about a specific event.
- `update`: Modify the details of an existing event.
- `delete`: Delete an event from your calendar.
- `next`: Navigate to the events of the upcoming week.
- `prev`: Navigate to the events of the previous week.
- `exit`: Close the CalenCLI application.

---

_Note: CalenCLI is a project developed for educational purposes and may not offer full-fledged calendar functionality. It serves as a demonstration of Ruby programming skills and command-line application development._
