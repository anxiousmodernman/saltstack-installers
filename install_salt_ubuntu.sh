#!/bin/bash

# Install Salt Minion on ubuntu 

# Default package to install is salt-minion
MINION_OR_MASTER="minion"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! -z $1 ]; then
  if [[ $1 == "master" ]]; then
    $MINION_OR_MASTER=$1
  else
    echo "Invalid argument. Valid args are: master"
    exit 1
  fi
fi


wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -

deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main

apt-get install salt-${MINION_OR_MASTER}

