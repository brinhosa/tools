# tools

One tool that you can use to automatically use different proxies from a list of free web proxies is the proxychains utility. This tool allows you to specify a list of proxies in a configuration file, and then use those proxies when running other command-line applications.

To use proxychains, you would first need to create a list of free web proxies that you want to use. This can be done by finding a website that offers a list of free web proxies and saving the list to a file. Then, you would need to configure proxychains to use the proxies in that file. This can be done by editing the proxychains.conf file, which is usually located in the /etc/proxychains.conf directory.

Once you have configured proxychains, you can use it to run other command-line applications and automatically use the proxies in your list. For example, if you wanted to use proxychains to run the curl command, you could use the following command:

Copy code
proxychains curl [url]
This would run the curl command and automatically use the proxies in your list to make the request.

There is no built-in proxychains command that you can use to get a list of free web proxies and update your list of proxies. However, you can use the curl command to download a list of free web proxies from the internet and save it to a file. Then, you can use the cat command to view the contents of the file and manually update your list of proxies in the proxychains.conf configuration file.

For example, if you have saved a list of free web proxies to a file called proxies.txt, you can use the following commands to view the contents of the file and update your list of proxies:

Copy code
cat proxies.txt
This will display the contents of the proxies.txt file on the command line. You can then copy and paste the proxy addresses from this file into your proxychains.conf configuration file.

Copy code
nano /etc/proxychains.conf
This will open the proxychains.conf file in the nano text editor, where you can edit the list of proxies. Once you have updated the list of proxies, save the file and exit the text editor.

You can then use the proxychains utility to run other command-line applications and automatically use the proxies in your updated list. For example, if you wanted to use proxychains to run the curl command, you could use the following command:

Copy code
proxychains curl [url]
This would run the curl command and automatically use the proxies in your updated list to make the request.

#!/bin/bash

# Define a URL for a web page that contains a list of free web proxies
PROXY_LIST_URL="https://free-proxy-list.net"

# Use the curl command to download the web page
curl $PROXY_LIST_URL > proxy_list.html

# Use the grep command to search the downloaded web page for proxy addresses
grep -Eo '(http|https)://[^"]+' proxy_list.html > proxies.txt

# Use the cat command to view the contents of the proxies.txt file
cat proxies.txt

#!/bin/bash

# Update the list of free proxies
wget -q -O - https://free-proxy-list.net/ | grep -Eo '<td>([0-9]{1,3}\.){3}[0-9]{1,3}</td>' | sed 's/<td>//g' | sed 's/<\/td>//g' > /tmp/free-proxies.txt

# Update the proxychains configuration file
PROXYCHAINS_CONF_FILE="/etc/proxychains.conf"

# Backup the original proxychains configuration file
cp $PROXYCHAINS_CONF_FILE "$PROXYCHAINS_CONF_FILE.bak"

# Clear the existing proxy list in the proxychains configuration file
sed -i '/^[^#]*socks4/d' $PROXYCHAINS_CONF_FILE

# Add the new list of free proxies to the proxychains configuration file
while read -r proxy; do
  echo "socks4 $proxy 1080" >> $PROXYCHAINS_CONF_FILE
done < /tmp/free-proxies.txt

# Clean up
rm /tmp/free-proxies.txt

#!/bin/bash

# Get the latest list of free proxies
proxies=$(curl -s "https://www.proxy-list.download/api/v1/get?type=http")

# Update the list of proxies in proxychains
echo "$proxies" | tr "," "\n" > /etc/proxychains.conf





