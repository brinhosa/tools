#!/bin/bash

# Check if a URL was provided as input
if [ -z "$1" ]; then
  echo "Please provide a URL to scan as input"
  exit 1
fi

# Normalize the URL for use in the output filenames
normalized_url=$(echo "$1" | sed -e 's/[^a-zA-Z0-9_\.-]/-/g')

# Run sqlmap to scan the URL for SQL injection vulnerabilities
echo "Running sqlmap scan on $1..."
docker run --rm -v $(pwd)/sqlmap_output_$normalized_url.txt:/root/sqlmap_output.txt owasp/sqlmap -u "$1" > /dev/null

# Run sqlninja to scan the URL for SQL injection vulnerabilities
echo "Running sqlninja scan on $1..."
docker run --rm -v $(pwd)/sqlninja_output_$normalized_url.txt:/root/sqlninja_output.txt s4n7h0/sqlninja -u "$1" > /dev/null

# Run sqlmate to scan the URL for SQL injection vulnerabilities
echo "Running sqlmate scan on $1..."
docker run --rm -v $(pwd)/sqlmate_output_$normalized_url.txt:/root/sqlmate_output.txt sqlmate/sqlmate -u "$1" > /dev/null

echo "Scan complete!"
