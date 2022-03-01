#!/bin/bash
cd /tmp
#download  and install the epel and java
amazon-linux-extras install epel -y 
amazon-linux-extras install java-openjdk11 -y
#jenkins download and installatin
cd /opt
#Enable EPEL
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
#installing jenkins with rpm 
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#update
yum update -y
#jenkins install
yum install jenkins -y
#enable the OS level service
systemctl enable jenkins
#start jenkin server
systemctl start jenkins





#!/bin/bash
cd /tmp
#download  and install the java 
apt-get update -y
apt-get install default-jdk -y
cd /opt
#Enable EPEL
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
#import and packager for repo
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
#update
apt-get update -y
#jenkins install
apt-get install jenkins -y
#enable the OS level service
systemctl enable jenkins
#start jenkin server
systemctl start jenkins

