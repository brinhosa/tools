#!/bin/bash

# Store the domain we want to discover the IP for in a variable
domain="example.com"

# Use Docker to run the Cloudflare resolver tool
docker run -it --rm anster/cloudflare-resolver $domain
