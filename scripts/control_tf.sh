#!/bin/bash

if [ ! -f "/home/vagrant/.ssh/id_rsa" ]; then
    ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
fi

cp /home/vagrant/.ssh/id_rsa.pub /vagrant/control.pub

cat << 'SSHEOF' > /home/vagrant/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
SSHEOF

mkdir -p /home/vagrant/playground

chown -R vagrant:vagrant /home/vagrant/.ssh/
chown -R vagrant:vagrant /home/vagrant/playground/

sudo apt-get update -qq 2>&1 >/dev/null
sudo apt-get update
#sudo apt-get install software-properties-common -y 2>&1 >/dev/null
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y 2>&1 >/dev/null