#!/bin/bash

# Task Scheduler Script

# File to store scheduled tasks
TASK_FILE="tasks.txt"

# Function to display the menu
display_menu() {
    echo "Task Scheduler"
    echo "1. Add Task"
    echo "2. List Tasks"
    echo "3. Run Tasks"
    echo "4. Exit"
}

# Function to add a task
add_task() {
    read -p "Enter the command to schedule: " command
    read -p "Enter the interval (in seconds): " interval
    echo "$command $interval" >> "$TASK_FILE"
    echo "Task added!"
}

# Function to list tasks
list_tasks() {
    if [[ -f "$TASK_FILE" ]]; then
        echo "Scheduled Tasks:"
        cat "$TASK_FILE"
    else
        echo "No tasks scheduled."
    fi
}

# Function to run tasks
run_tasks() {
    if [[ -f "$TASK_FILE" ]]; then
        while IFS= read -r line; do
            command=$(echo "$line" | awk '{print $1}')
            interval=$(echo "$line" | awk '{print $2}')
            echo "Running: $command"
            eval "$command"
            sleep "$interval"
        done < "$TASK_FILE"
    else
        echo "No tasks to run."
    fi
}

# Main loop
while true; do
    display_menu
    read -p "Choose an option: " option
    case $option in
        1) add_task ;;
        2) list_tasks ;;
        3) run_tasks ;;
        4) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
