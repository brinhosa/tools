#!/bin/bash

# Check if a URL was provided
if [ -z "$1" ]; then
  echo "Please provide a URL as input"
  exit 1
fi

# Set the URL
url=$1

# Normalize the URL
normalized_url=$(echo $url | sed -e 's/https\?:\/\///g' -e 's/[^a-zA-Z0-9\.-]/-/g')

# Use nuclei to scan for vulnerabilities
echo "Running nuclei for $url"
docker run --rm -it nuclei/nuclei -t ./nuclei-templates/url-templates.yaml -u $url > nuclei-results-$normalized_url.txt

# Use jaeles to scan for vulnerabilities
echo "Running jaeles for $url"
docker run --rm -it jaeles/jaeles scan -s ./jaeles-signatures/ -u $url > jaeles-results-$normalized_url.txt

# Use tsunami to scan for vulnerabilities
echo "Running tsunami for $url"
docker run --rm -it fn0rd/tsunami -u $url > tsunami-results-$normalized_url.txt

# Use sqlmap to scan for SQL injection vulnerabilities
echo "Running sqlmap for $url"
docker run --rm -it sqlmapproject/sqlmap -u $url > sqlmap-results-$normalized_url.txt

# Use nikto to scan for vulnerabilities
echo "Running nikto for $url"
docker run --rm -it cirt/nikto -h $url > nikto-results-$normalized_url.txt

echo "Finished running vulnerability assessment tools for $url"
