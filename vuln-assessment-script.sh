#!/bin/bash
#docker pull m4ll0k/subbrute
#docker search amass

# Check if a URL or domain was provided
if [ -z "$1" ]; then
  echo "Please provide a URL or domain as input"
  exit 1
fi

# Set the URL or domain
url=$1

# Use nuclei to scan for vulnerabilities
echo "Running nuclei for $url"
docker run --rm -it nuclei -t ./nuclei-templates/url-templates.yaml -u $url > nuclei-results-$url.txt

# Use jaeles to scan for vulnerabilities
echo "Running jaeles for $url"
docker run --rm -it jaeles scan -s ./jaeles-signatures/ -u $url > jaeles-results-$url.txt

# Use tsunami to scan for vulnerabilities
echo "Running tsunami for $url"
docker run --rm -it tsunami -u $url > tsunami-results-$url.txt

# Use sqlmap to scan for SQL injection vulnerabilities
echo "Running sqlmap for $url"
docker run --rm -it sqlmap -u $url > sqlmap-results-$url.txt

# Use nikto to scan for vulnerabilities
echo "Running nikto for $url"
docker run --rm -it nikto -h $url > nikto-results-$url.txt

echo "Finished running vulnerability assessment tools for $url"
