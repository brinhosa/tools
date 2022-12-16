import os
import azure.mgmt.network

# Set up the Azure client using the credentials from the environment
credentials = azure.common.credentials.ServicePrincipalCredentials(
    client_id=os.environ['AZURE_CLIENT_ID'],
    secret=os.environ['AZURE_CLIENT_SECRET'],
    tenant=os.environ['AZURE_TENANT_ID']
)
client = azure.mgmt.network.NetworkManagementClient(credentials)

# Initialize a list to store the exposed domains and IPs
exposed_domains_and_ips = []

# Get a list of all the public IP addresses in the subscription
public_ips = client.public_ip_addresses.list_all()

# Iterate through the public IP addresses
for public_ip in public_ips:
    # Check if the public IP is associated with a load balancer
    if public_ip.load_balancer_id is not None:
        # If the public IP is associated with a load balancer, get the name of the load balancer
        lb_name = public_ip.load_balancer_id.split('/')[-1]

        # Get the details of the load balancer
        lb = client.load_balancers.get(public_ip.resource_group_name, lb_name)

        # Iterate through the load balancer's inbound NAT rules
        for inbound_nat_rule in lb.inbound_nat_rules:
            # Check if the inbound NAT rule allows incoming traffic from anywhere (0.0.0.0/0)
            if inbound_nat_rule.backend_address_pool.id is None:
                # Check if the inbound NAT rule allows incoming traffic on any port
                if inbound_nat_rule.frontend_port_range_end == 65535:
                    # In this case, the inbound NAT rule allows incoming traffic from anywhere on any port,
                    # so it is exposing the domain or IP associated with the inbound NAT rule
                    exposed_domains_and_ips.append(inbound
