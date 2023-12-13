#!/bin/bash

# First we are going to see if the user wants to run as root, or if they are root currently. 

clear

#Fun beginning

echo "."
sleep 1
clear
echo ".."
sleep 1
clear
echo "..."
sleep 1
clear
sleep 1
echo "Please wait as we hack into the mainframe"
sleep 2
clear
echo "Im in!"
sleep 2
clear

echo "Hello friends!"
sleep 2
clear
echo "Our name is Server-Boyz"
sleep 2
clear
echo "Please hold while we check to see if you are root"
sleep 2
echo

if [ "$(id -u)" == "0" ]; then
    echo "Looks like you are already running as root. TSK-TSK Naughty-Naughty! I guess we will proceed with the script..."
    sleep 3
else
    # Prompt the user to decide whether to elevate to root
    read -p "This script requires root privileges. Do you want to elevate to root? (yes/no): " answer

    if [ "$answer" == "yes" ]; then
        # Elevate to root using sudo
        echo "Thanks for your consent. Consent is paramount to life! We are going to try this again."
        sleep 2
        sudo chmod +x build-docker.sh
        sudo ./build-docker.sh  # Run the script again with sudo
        exit $?   
    else
        echo "Script aborted. lol. It requires root privileges to proceed."
        sleep 2
        exit 1
    fi
fi

clear
sleep 2
echo "Now we are going to install docker and docker compose!"
sleep 2
clear
# Add Docker's official GPG key:
apt-get update
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

clear
sleep 2

install_portainer_ce() {
    echo "Installing Portainer-CE via Docker..."
    sleep 2
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
    sleep 2
    echo "Portainer-CE installed successfully!"
    sleep 2
}

# Function to install Portainer Agent
install_portainer_agent() {
    echo "Installing Portainer Agent via Docker..."
    sleep 2
    docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
    sleep 2
    echo "Portainer Agent installed successfully!"
    sleep 2
}

# Main script
read -p "Do you want to install Portainer? (yes/no): " install_portainer

    if [ "$install_portainer" == "yes" ]; then
        read -p "Do you want to install Portainer-CE or Portainer Agent? (portainer-ce/portainer-agent): " install_type

        if [ "$install_type" == "portainer-ce" ]; then
            install_portainer_ce
        elif [ "$install_type" == "portainer-agent" ]; then
            install_portainer_agent
        else
            echo "You obviously don't read or follow directions do you? I'm gone!"
            sleep 2
            exit 1
        fi
    else
        echo "No you don't want portainer? OKAY THEN, I GUESS IT'S FINE! Continuing with the script..."
        sleep 2
    fi

clear 
sleep 2
echo "Now that docker is installed we just need to get your IP address for you!"
sleep 2
clear

local_ip=$(hostname -I | awk '{print $1}')

# Check if the IP address is not empty
if [ -n "$local_ip" ]; then
  echo "Your IP address is: $local_ip"
else
  echo "Unable to determine IP address. Please make sure that your ethernet cable is plugged in"
fi

echo
sleep 2
echo "Awesome! Looks like everything is installed."
echo 
echo "If you installed Portainer-CE, head over to https://$local_ip:9443"
echo
echo "If you installed Portainer-Agent, make sure to login to your Main portainer instance and add it as an environment."
echo 
echo 'Thank you for using our script! Have a great day! - The Server-Boyz'

