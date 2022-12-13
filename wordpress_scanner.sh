#!/bin/bash

# Check if a URL was provided
if [ -z "$1" ]; then
  echo "Please provide a URL to scan"
  exit 1
fi

# Use wpscan in a docker container to find the WordPress version
wordpress_version=$(docker run -v "$PWD":/data wpscanteam/wpscan --url $1 --format cli --no-update | grep "WordPress version" | awk '{print $4}')

# Check if WordPress is running on the URL
if [ -z "$wordpress_version" ]; then
  echo "WordPress is not running on the provided URL"
  exit 1
fi

# Use searchsploit in a docker container to look for known exploits for the WordPress version
docker run -v "$PWD":/data exploitdb/exploitdb search -w wordpress $wordpress_version
