#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
#systemctl stop httpd



#!/bin/bash
apt-get update
apt-get install apache2 -y
systemctl enable apache2
systemctl start apache2
#systemctl stop apache2
