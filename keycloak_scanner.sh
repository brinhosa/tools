#!/bin/bash
#apt install nmap exploitdb
# Check if a URL was provided
if [ -z "$1" ]; then
  echo "Please provide a URL to scan"
  exit 1
fi

# Use nmap to find the Keycloak version
keycloak_version=$(nmap -sV -p 80,443 --script keycloak-info $1 | grep "Keycloak" | awk '{print $3}')

# Check if Keycloak is running on the URL
if [ -z "$keycloak_version" ]; then
  echo "Keycloak is not running on the provided URL"
  exit 1
fi

# Use searchsploit to look for known exploits for the Keycloak version
searchsploit -w keycloak $keycloak_version
