# Import the necessary libraries
import adal
import msrest

# Set the tenant ID and client ID for Azure AD
tenant_id = "<your-tenant-id>"
client_id = "<your-client-id>"

# Authenticate using Azure AD
context = adal.AuthenticationContext("https://login.microsoftonline.com/" + tenant_id)
token_response = context.acquire_token_with_client_credentials(
    "https://graph.microsoft.com",
    client_id,
    "<your-client-secret>"
)

# Use the authentication token to create a client for the Microsoft Graph API
graph_client = msrest.DelegatingAuthentication(
    lambda: (token_response["tokenType"], token_response["accessToken"])
)

# Use the client to query the Microsoft Graph API for Azure AD data
result = graph_client.users.list()

# Print the result
print(result)
