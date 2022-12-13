# Start the scan in the background
gvm-cli scan start --target <target> --scan-type <type> &

# Check the progress of the scan periodically
while true; do
  progress=$(gvm-cli scan progress <scan-id>)
  echo "Scan progress: $progress%"
  if [ "$progress" -eq 100 ]; then
    break
  fi
  sleep 60
done

# Retrieve the scan results
results=$(gvm-cli scan results <scan-id>)

# Save the results to a file
echo "$results" > scan-results.txt
