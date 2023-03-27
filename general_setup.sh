#!/bin/bash

sudo apt update

echo "installing Java JRE"

sudo apt install -y default-jre

java -version

echo "installing Java JDK"

sudo apt install -y default-jdk

javac -version

echo "add the repository key"

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg


echo "append the Debian package repository address"

sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update

echo "installin Jenkins"

sudo apt install -y jenkins

echo "starting Jenkins"

sudo systemctl start jenkins.service

echo "opening the firewall"

sudo ufw enable
sudo ufw allow 8080
sudo ufw allow 22

sudo apt-get update

sudo apt install -y docker.io

sudo snap install -y docker

sudo apt-get install -y docker-compose-plugin
