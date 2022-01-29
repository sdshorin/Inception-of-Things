#!/bin/bash

# ssh-keygen -t rsa
# iception

echo "Hi here!!"
cp /home/vagrant/.ssh/key.pub /home/vagrant/.ssh/authorized_keys
sudo mkdir /root/.ssh
cp /home/vagrant/.ssh/key.pub /root/.ssh/authorized_keys


curl -sfL https://get.k3s.io | sh -

