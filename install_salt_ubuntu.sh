#!/bin/bash

# Install Salt Minion on ubuntu 



if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -

deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main

apt-get install salt-minion

