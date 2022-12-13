import adal
import requests

# Set the tenant ID, client ID, and client secret
tenant = "your-tenant-id"
client = "your-client-id"
secret = "your-client-secret"

# Authenticate using the Azure AD client credentials
context = adal.AuthenticationContext("https://login.windows.net/" + tenant)
token = context.acquire_token_with_client_credentials(
    "https://graph.microsoft.com",
    client,
    secret
)

# Set the headers for the HTTP request
headers = {
    "Authorization": "Bearer " + token["accessToken"],
    "Content-Type": "application/json"
}

# Set the URL for the Azure AD audit logs
url = "https://graph.microsoft.com/v1.0/auditLogs/signIns"

# Send the HTTP request and get the response
response = requests.get(url, headers=headers)

# Print the response
print(response.text)
