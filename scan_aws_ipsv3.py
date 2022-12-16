import boto3
import os
import socket

# Set up the AWS client using the credentials from the environment
client = boto3.client('ec2',
                      aws_access_key_id=os.environ['AWS_ACCESS_KEY_ID'],
                      aws_secret_access_key=os.environ['AWS_SECRET_ACCESS_KEY'])

# Get a list of all the VPCs in the account
vpcs = client.describe_vpcs()['Vpcs']

# Initialize a list to store the exposed domains and IPs
exposed_domains_and_ips = []

# Iterate through each VPC
for vpc in vpcs:
    # Get a list of all the security groups in the VPC
    security_groups = client.describe_security_groups(
        Filters=[{'Name': 'vpc-id', 'Values': [vpc['VpcId']]}]
    )['SecurityGroups']

    # Iterate through each security group
    for group in security_groups:
        # Get a list of all the ingress rules in the security group
        ingress_rules = group['IpPermissions']

        # Iterate through each ingress rule
        for rule in ingress_rules:
            # Check if the rule allows incoming traffic from anywhere (0.0.0.0/0)
            if rule['IpRanges'][0]['CidrIp'] == '0.0.0.0/0':
                # Check if the rule allows incoming traffic on any port
                if rule['ToPort'] == -1:
                    # In this case, the security group allows incoming traffic from anywhere on any port,
                    # so it is exposing the domain or IP associated with the security group
                    exposed_domains_and_ips.append(group['GroupName'])
                else:
                    # In this case, the security group allows incoming traffic from anywhere on a specific port,
                    # so it is exposing the domain or IP associated with the security group on that port
                    exposed_domains_and_ips.append(f"{group['GroupName']}:{rule['ToPort']}")

# Check if there are any new exposed domains or IPs
new_exposed_domains_and_ips = set(exposed_domains_and_ips) - set(previous_exposed_domains_and_ips)

# If there are new exposed domains or IPs, send a message
if new_exposed_domains_and_ips:
    # Send a message (modify this command as necessary for your use case)
    message = "New exposed domains and IPs:\n" + "\n".join(new_exposed_domains_and_ips)
    print(message)

# Update the list of previous exposed domains and IPs
previous_exposed_domains_and_ips = exposed_domains_and_ips
