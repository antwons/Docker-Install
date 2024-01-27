#!/bin/bash

clear
echo "Welcome to Antwon's Docker install Script!"
sleep 2
echo 
echo "In this install script, we are going to install Docker, Docker Compose and it's depencies required to run."
sleep 2
echo 
echo "Here we go!"
sleep 2
clear

echo "we are first going to check that you are running as root!"
if [ "$(id -u)" == "0" ]; then
    echo "You are currently running as root, we will proceed!"
    sleep 3
else
    # Prompt the user to decide whether to elevate to root
    read -p "This script requires root privileges. Do you want to elevate to root? (yes/no): " answer

    if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
        # Elevate to root using sudo
        echo "Thanks for your consent. Consent is paramount to life! We are going to try this again."
        sleep 2
        sudo chmod +x debian-build.sh
        sudo ./debian-build.sh  # Run the script again with sudo
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

apt-get update
apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt-cache policy docker-ce
apt install docker-ce
clear
sleep 2

# Function to install Portainer-CE
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

    if [[ "$install_portainer" == "yes" || "$install_portainer" == "y" ]]; then
        read -p "Do you want to install Portainer-CE or Portainer Agent? (portainer-ce/portainer-agent): " install_type

        if [ "$install_type" == "portainer-ce" ]; then
            install_portainer_ce
        elif [ "$install_type" == "portainer-agent" ]; then
            install_portainer_agent
        else
            echo "That was not an option, please re-run the script."
            sleep 2
            exit 1
        fi
    else
        echo "You've opted to not install Portainer. We will continue."
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
echo "Thank you for using our script! Have a great day! - Antwons!"