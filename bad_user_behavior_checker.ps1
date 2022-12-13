# Get the list of event logs
$event_logs = Get-WinEvent -ListLog *

# Iterate over each event log
foreach ($event_log in $event_logs)
{
  # Get the events from the current log
  $events = Get-WinEvent -LogName $event_log.LogName

  # Iterate over each event
  foreach ($event in $events)
  {
    # Check if the event contains any of the following keywords, indicating bad user behavior
    if ($event.Message -match "malicious|virus|trojan|ransomware|phishing|spam|unauthorized")
    {
      # Print the details of the event
      Write-Host "Log: $($event_log.LogName)"
      Write-Host "ID: $($event.Id)"
      Write-Host "Message: $($event.Message)"
      Write-Host "-------------------"
    }
  }
}
