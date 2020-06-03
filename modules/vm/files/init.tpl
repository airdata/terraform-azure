#!/bin/sh
apt-get -y update > /dev/null 2>&1
apt-get -y install \
   apt-transport-https \
   ca-certificates curl \
   software-properties-common > /dev/null 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  > /dev/null 2>&1
sudo apt-key fingerprint 0EBFCD88  > /dev/null 2>&1
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"  > /dev/null 2>&1
sudo apt-get -y update  > /dev/null 2>&1
sudo apt-get -y install \
   docker-ce \
   docker-ce-cli \
   containerd.io  > /dev/null 2>&1
sudo systemctl enable docker > /dev/null 2>&1
sudo systemctl start docker > /dev/null 2>&1
sudo docker login -u ${acr_admin_username} -p ${acr_admin_password} ${acr_login_server}
echo "Docker is installed & LogIn to repository"
