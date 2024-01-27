#!/bin/bash 

#This script is meant to ask the user to select between  installing docker with Portainer or Ubuntu. 

clear
echo "Hello, welcome to Antwons Docker Install menu"
sleep 3
clear

echo "Please select what OS you are currently running."
echo
echo "1. Ubuntu"
echo "2. Debain"
echo "3. Raspberry Pi OS (64 BIT VERSION)"
echo "4. Fedora"
echo "5. CentOS"
echo

read -p "Please enter the number of your choice (1-5): " choice

case $choice in
  1)
    echo "We will go ahead and start installing Docker for Ubuntu"
    sleep 2
    bash ubuntu-build.sh
    ;;
  2)
    echo "We will go ahead and start installing Docker for Debain"
    sleep 2
    bash debian-build.sh
    ;;
  3)
    echo "We will go ahead and start installing Docker for Raspberry PI OS (64 BIT VERSION)"
    sleep 2
    bash debian-build.sh
    ;;
  4)
    echo "We will go ahead and start installing Docker for Fedora"
    sleep 2
    bash fedora-build.sh
    ;;
  3)
    echo "We will go ahead and start installing Docker for CentOS"
    sleep 2
    bash centos-build.sh
    ;;
  *)
    echo "Invalid choice. Please enter a number between 1 and 5."
    ;;
esac