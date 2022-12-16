#!/bin/bash
#0 0 * * * /path/to/scan_urls.sh
#crontab -e

# Get the current date and time in a standardized format
current_date=$(date +"%Y%m%d%H%M%S")

# Read the list of URLs from the specified file
url_list=$(cat /path/to/urls.txt)

# Loop through each URL in the list
for url in $url_list; do
  # Normalize the URL by removing any trailing slashes
  normalized_url=$(echo $url | sed 's/\/$//')

  # Run wappalyzer on the URL using the docker tool
  wappalyzer_output=$(docker run --rm wappalyzer/cli $url)

  # Save the wappalyzer output to a file with the normalized URL and current date/time
  echo $wappalyzer_output > /path/to/output/${normalized_url}_${current_date}.txt

  # Check if there is a previous scan for this URL
  if [ -f /path/to/output/${normalized_url}_prev.txt ]; then
    # Compare the current scan with the previous scan to find any new technologies
    new_technologies=$(diff /path/to/output/${normalized_url}_prev.txt /path/to/output/${normalized_url}_${current_date}.txt | grep "^>" | cut -c3-)

    # Check if there are any new technologies
    if [ ! -z "$new_technologies" ]; then
      # Send a message with the new technologies detected
      echo "New technologies detected for URL: $url"
      echo "Technologies: $new_technologies" | mail -s "New Technologies Detected" user@example.com
    fi
  fi

  # Update the previous scan file with the current scan
  mv /path/to/output/${normalized_url}_${current_date}.txt /path/to/output/${normalized_url}_prev.txt
done
