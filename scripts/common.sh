#!/bin/bash

echo "mise à jour et installation des packages utils"

echo "
10.0.20.10 control-tf
" >> /etc/hosts
sed -i '/127.0.1.1/d' /etc/hosts

echo "set ts=2 sw=2 et" >> /home/vagrant/.vimrc

chown -R vagrant:vagrant /home/vagrant/.vimrc