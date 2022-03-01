#sonarqube installation on amazon linux
#pre-req
#1.An EC2 instance with a minimum of 2 GB RAM (t2.mediam)
#	sg--> 22 myip, 9000 anywhere

#2.Java 11 installation

#3.SonarQube cannot be run as root on Unix-based systems, 
#so create a dedicated user account for SonarQube if necessary.







#!/bin/bash
cd /tmp
#download  and install the epel and java
amazon-linux-extras install epel -y 
amazon-linux-extras install java-openjdk11 -y

#Download SonarQube && extract packages
cd /opt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.7.52159.zip
unzip sonarqube-8.9.7.52159.zip
#create user
useradd sonaradmin
#Change ownership to the user
chown sonaradmin:sonaradmin sonarqube-8.9.7.52159
#permission
chmod -R 777 sonarqube-8.9.7.52159
#switch user
su - sonaradmin
#Start service
sh /opt/sonarqube-8.9.7.52159/bin/linux-x86-64/sonar.sh start

#Status check
sh /opt/sonarqube-8.9.7.52159/bin/linux-x86-64/sonar.sh status

#Connect to the SonarQube server through the browser. It uses port 9000.
#http://<Public-IP>:9000


#default username : admin
#        passwrd  : admin








