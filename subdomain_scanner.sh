#!/bin/bash

# 
# Define the domain to scan
domain=$1

# Create a directory to store the reports
mkdir -p reports

# Run the sublist3r Docker image
docker run -it --rm \
    -v $PWD/reports:/app/reports \
    aboul3la/sublist3r \
    -d $domain -o /app/reports/sublist3r.txt

# Run the aquatone Docker image
docker run -it --rm \
    -v $PWD/reports:/app/reports \
    michenriksen/aquatone \
    -scan-timeout 3000 -threads 100 \
    -chrome-path /usr/bin/chromium-browser \
    $domain

# Run the subfinder Docker image
docker run -it --rm \
    -v $PWD/reports:/app/reports \
    projectdiscovery/subfinder \
    -d $domain -o /app/reports/subfinder.txt

# Run the subover Docker image
docker run -it --rm \
    -v $PWD/reports:/app/reports \
    hypsurus/subover \
    -l $domain -o /app/reports/subover.txt

# Concatenate the reports into a single file
cat $PWD/reports/*.txt > $PWD/reports/all.txt
