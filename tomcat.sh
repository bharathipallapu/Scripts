#!/bin/bash
cd /tmp
#download  and install the java 
amazon-linux-extras install epel -y
amazon-linux-extras install java-openjdk11 -y
cd /opt
# install tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58-windows-x64.zip
#unzip the tomcat
unzip apache-tomcat-9.0.58-windows-x64.zip
#rename tomcat
mv apache-tomcat-9.0.58 tomcat9
# change the permissions
chmod -R 700 /opt/tomcat9/
# remove the zip file
rm -f apache-tomcat-9.0.58-windows-x64.zip
# start the apache tomcat pre req is the java for the tomacat
sh /opt/tomcat9/bin/startup.sh




#!/bin/bash
cd /tmp
#download  and install the java 
apt-get update -y
apt-get install default-jdk -y
cd /opt
# install tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58-windows-x64.zip
#unzip the tomcat
apt install unzip -y
unzip apache-tomcat-9.0.58-windows-x64.zip
#rename tomcat
mv apache-tomcat-9.0.58 tomcat9
# change the permissions
chmod -R 700 /opt/tomcat9/
# remove the zip file
rm -f apache-tomcat-9.0.58-windows-x64.zip
# start the apache tomcat pre req is the java for the tomacat
sh /opt/tomcat9/bin/startup.sh

