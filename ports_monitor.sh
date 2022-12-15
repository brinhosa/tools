#!/bin/bash

# Set the host to scan
HOST=<hostname or IP address>

# Set the file to save the previous scan results
LAST_SCAN_FILE=last_scan.txt

# Run nmap in a Docker container to scan the host
NMAP_OUTPUT=$(docker run --rm nmap -p- $HOST)

# Extract the list of open ports from the nmap output
OPEN_PORTS=$(echo "$NMAP_OUTPUT" | grep -Eo '[0-9]{1,5}/[a-z]+' | cut -d'/' -f1)

# If the last scan file exists, read the list of open ports from it
if [ -f $LAST_SCAN_FILE ]; then
  LAST_SCAN_PORTS=$(cat $LAST_SCAN_FILE)
fi

# Compare the current and last scan results
if [ "$OPEN_PORTS" != "$LAST_SCAN_PORTS" ]; then

  # Save the current scan results to the last scan file
  echo "$OPEN_PORTS" > $LAST_SCAN_FILE

  # Send a message with the new open ports
  echo "New open ports: $OPEN_PORTS" | mail -s "New open ports on $HOST" <email address>
fi
