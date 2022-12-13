#!/bin/bash

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: Docker is not installed. Please install Docker and try again.' >&2
  exit 1
fi

# Check if the Cloudflare resolver image is pulled
if ! [ "$(docker images -q cloudflare-resolver)" ]; then
  # Pull the Cloudflare resolver image from Docker Hub
  docker pull seanthegeek/cloudflare-resolver
fi

# Loop through each domain passed as an argument to the script
for domain in "$@"
do
  # Run the Cloudflare resolver image and pass the domain as an argument
  # The real IP address is printed to stdout
  docker run --rm seanthegeek/cloudflare-resolver "$domain"
done
