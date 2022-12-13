#!/bin/bash

# Check if a URL was provided
if [ -z "$1" ]; then
  echo "Please provide a URL to scan"
  exit 1
fi

# Normalize the URL
normalized_url=$(echo $1 | sed -e 's/https\?:\/\///g' -e 's/\/$//g')

# Run dalfox on the URL
docker run -v "$PWD":/data dalfox/dalfox scan -u "$1" > "dalfox-$normalized_url.txt"

# Run xssstrike on the URL
docker run -v "$PWD":/app xssstrike -u "$1" > "xssstrike-$normalized_url.txt"

# Run xsser on the URL
docker run -v "$PWD":/data xsser -u "$1" > "xsser-$normalized_url.txt"

# Run xss hunter on the URL
docker run -v "$PWD":/data xsshunter/xsshunter -u "$1" > "xsshunter-$normalized_url.txt"
