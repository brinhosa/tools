#!/bin/bash

# Create a temporary file to store the current scan results
temp_file=$(mktemp)

# Scan all URLs in the input file and store the results in the temporary file
while read url; do
  # Normalize the URL
  normalized_url=$(echo "$url" | sed -e 's/[^[:alnum:]]/-/g')

  # Run the scan with whatweb and store the results in the temporary file
  docker run --rm mazzolino/whatweb "$url" >> "$temp_file"
done < input_file.txt

# Compare the current scan results with the previous results
diff -q "$temp_file" previous_results.txt > /dev/null

# If there are differences, send a message and update the previous results file
if [ $? -ne 0 ]; then
  # Send a message (modify this command as necessary for your use case)
  echo "There are new technologies in the scan results!" | mail -s "Web Technology Update" your@email.com

  # Update the previous results file
  cp "$temp_file" previous_results.txt
fi

# Remove the temporary file
rm "$temp_file"
