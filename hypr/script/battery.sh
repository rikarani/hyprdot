#!/usr/bin/env bash

# This script checks the battery status and outputs the percentage and charging state.
battery_info=$(cat /sys/class/power_supply/BAT0/status)
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

icon_index=$((battery_percentage / 10))

if [ "$icon_index" -eq 10 ]; then
    icon_index=9  # Cap at the last icon for 100%
fi

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
	battery_icon="$charging_icon"
fi

# Output the battery percentage and icon
echo "$battery_icon $battery_percentage% $battery_info"