## Welcome to our simple Docker Install Script

> <span style="color:red"> Please note that this script has only been tested with Ubuntu, Debian and Raspberry PI OS 64 BIT at this time </span>

### To begin with our install, copy the following and paste into the terminal of your server! 
```
sudo apt install git -y && sudo git clone https://github.com/antwons/Docker-Install.git && cd Docker-Install/scripts && bash menu.sh
```

### FAQ's 

#### *What does this script do exactly?*
> This script will first ask you what OS you want to get Docker for. We ask this as we want to make sure it installs properly for the OS that you have! Then it will proceed to run the script based off the OS. In that script for your os, it downloads docker & docker compose. All will be at the lastest versions, so if you have any questions please review [Docker's documentation](https://docs.docker.com/).
>
> After installing the correct version of docker, it will ask you if you want to install Portainer-CE, Portainer-Agent or not download it at all. Portainer-CE is the community edition of Portainer and best used if this is the first instance of Portainer for you. Portainer Agent is meant to install if you want to add the environment to an exisiting Portainer instance in your lab. For more information on Portainer, please review [Portainer's documentation](https://docs.portainer.io/).
>
> Once Portainer is installed or you've opted out of it, it will then grab you IP address and sever you with your machines current IP address along with the URL to go to if you did download Portainer.

#### *Why did you make this?*
> I made this script as a helpful tool for myself as I create and destroy many Virtual Machines (VM's) and often need to isntall docker & docker compose. Previously the "Docker.io & Docker-compose" install worked, but as I wanted to keep up to date with the direction docker is moving, I needed to create a script that installs the latest verion of docker all the time! Now, we have this!

#### *If I'm having any issues, who do I reach out to?* 
> Any issues that you are having, shoudl immediately be moved over to our issues tab and create a issue. Think of this like our helpdesk tickets. I will review these daily and get back to you asap!
