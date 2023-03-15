#!/bin/bash

# Check if a domain was provided
if [ -z "$1" ]; then
  echo "Please provide a domain as input"
  exit 1
fi

# Set the domain
domain=$1

# Set the output file
output="osint-results-$domain.txt"

# Create the output file
touch $output

# Use subbrute to find subdomains
echo "Running subbrute for $domain"
docker run --rm -it trickest/subbrute $domain >> $output

# Use amass to find subdomains
echo "Running amass for $domain"
docker run --rm -it caffix/amass enum -d $domain >> $output

# Use findomain to find subdomains
echo "Running findomain for $domain"
docker run --rm -it edu4rdshl/findomain -t $domain >> $output

# Use dnsrecon to find DNS records
echo "Running dnsrecon for $domain"
docker run --rm -it cr0hn/dnsrecon -d $domain >> $output

# Use theHarvester to find email addresses
echo "Running theHarvester for $domain"
docker run --rm -it simonthomas/theharvester -d $domain -b all >> $output

echo "Finished running OSINT tools for $domain"
