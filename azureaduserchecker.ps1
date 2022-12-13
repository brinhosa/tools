# Import the Azure AD module
Import-Module AzureAD

# Connect to Azure AD using an account with appropriate permissions
Connect-AzureAD

# Set the start and end dates for the event search
$startDate = (Get-Date).AddDays(-7)
$endDate = Get-Date

# Search for events related to bad user behavior
Search-AzureADAuditDirectoryLogs -StartDate $startDate -EndDate $endDate -Category "UserManagement" -ResultType "AccountManagement"
