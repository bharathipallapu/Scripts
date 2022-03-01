#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl enable nginx
systemctl start nginx
#systemctl stop nginx




#!/bin/bash
apt-get update
apt-get install nginx -y
systemctl enable nginx
systemctl start nginx
#systemctl stop nginx
