#!/bin/bash

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

rpm --import https://repo.saltstack.com/yum/redhat/6/x86_64/latest/SALTSTACK-GPG-KEY.pub

# Write the repo config file
cat >/etc/yum.repos.d/saltstack.repo <<EOL
[saltstack-repo]
name=SaltStack repo for RHEL/CentOS \$releasever
baseurl=https://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/latest
enabled=1
gpgcheck=1
gpgkey=https://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/latest/SALTSTACK-GPG-KEY.pub
EOL

# Begin the install
yum clean expire-cache
yum update -y

# By default we will install a minion and salt-ssh
yum install -y salt-${MINION_OR_MASTER}
yum install -y salt-ssh

