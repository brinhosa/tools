# Set the tenant ID and application ID
$tenantId = "<your-tenant-id>"
$applicationId = "<your-application-id>"

# Set the credentials for connecting to Azure AD
$username = "<your-username>"
$password = "<your-password>"
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential($username, $secpasswd)

# Connect to Azure AD
Connect-AzureAD -TenantId $tenantId -ApplicationId $applicationId -Credential $mycreds

# Get the list of users in Azure AD
$users = Get-AzureADUser

# Iterate over each user
foreach ($user in $users)
{
  # Check if the user has any of the following properties, indicating bad user behavior
  if ($user.AccountEnabled -eq $false -or $user.PasswordPolicies -ne "None")
  {
    # Print the details of the user
    Write-Host "User: $($user.DisplayName)"
    Write-Host "AccountEnabled: $($user.AccountEnabled)"
    Write-Host "PasswordPolicies: $($user.PasswordPolicies)"
    Write-Host "-------------------"
  }
}
