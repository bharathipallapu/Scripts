
#Prerequisites
#Ubuntu Server with 20.04 LTS
#JDK
#2 CPU and 4 GB RAM
#Open Ports 9200, 5601, 5044

#Elk-sg → 22 my ip, 9200 anywhere, 5601 anywhere, 5044 anywhere
#		        9200 apache-sg, 5601 apache-sg, 5044 apache-sg	

#Launch instance → t2.medium → elk → elk-sg



sudo su -
apt-get update -y


#Install java
apt-get install openjdk-11-jdk wget apt-transport-https curl gnupg2 -y
java -version

#elasticsearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch --no-check-certificate | sudo apt-key add -

echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

apt-get update -y
#Install elasticsearch
apt-get install elasticsearch -y

#elesticsearch configuration file change
nano /etc/elasticsearch/elasticsearch.yml
============================
network.host: 0.0.0.0

http.port: 9200

discovery.type: single-node
================================

systemctl start elasticsearch
systemctl enable elasticsearch
systemctl status elasticsearch
netstat -anlp | grep 9200
ss -antpl | sudo grep 9200
curl -X GET "0.0.0.0:9200"




#Logstash
#install Logstash
apt-get install logstash

nano /etc/logstash/conf.d/02-beats-input.conf
=================
input {

  beats {

    port => 5044

  }

}

==============

systemctl start logstash
systemctl enable logstash
systemctl status logstash

#Kibana
apt-get install kibana -y

nano /etc/kibana/kibana.yml
===================
server.port: 5601

server.host: "0.0.0.0"

elasticsearch.hosts: ["http://0.0.0.0:9200"]
==========================

systemctl start kibana
systemctl enable kibana
systemctl status kibana








#Launch instance → t2.medium → apache → apache-sg 22 my ip, 80 anywhere


sudo su -

yum install httpd
systemctl start httpd
systemctl enable httpd
systemctl status httpd
ps -ef | grep httpd
netstat -anlp | grep ":80"
netstat -anlp | grep httpd


#Filebeat

vi /etc/yum.repos.d/filebeat.repo
====================
[elastic-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md

==========


yum install filebeat
systemctl start filebeat
systemctl enable filebeat
systemctl status filebeat




vi /etc/filebeat/filebeat.yml
================
setup.kibana:
  # Kibana Host
  # Scheme and port can be left out and will be set to the default (http and 5601)
  # In case you specify and additional path, the scheme is required: http://localhost:5601/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:5601
  host: "172.31.18.199:5601"


output.elasticsearch:
  # Array of hosts to connect to.
  hosts: ["172.31.18.199:9200"]



#output.logstash:
  # The Logstash hosts
  #hosts: ["localhost:5044"]



setup.ilm.check_exists: true
setup.ilm.overwrite: true




==================

filebeat test output
filebeat modules list

*********
filebeat modules enable apache

cd /etc/filebeat/modules.d
nano apache.yml
===========
- module: apache
  # Access logs
  access:
    enabled: true

    # Set custom paths for the log files. If left empty,
    # Filebeat will choose the paths depending on your OS.
    var.paths: ["/var/log/httpd/access_log"]

  # Error logs
  error:
    enabled: true

    # Set custom paths for the log files. If left empty,
    # Filebeat will choose the paths depending on your OS.
    var.paths: ["/var/log/httpd/error_log"]


***********

filebeat modules enable nginx

cd /etc/filebeat/modules.d
nano nginx.yml
===========
- module: nginx
  # Access logs
  access:
    enabled: true

    # Set custom paths for the log files. If left empty,
    # Filebeat will choose the paths depending on your OS.
    var.paths: ["/var/log/nginx/access.log"]

  # Error logs
  error:
    enabled: true

    # Set custom paths for the log files. If left empty,
    # Filebeat will choose the paths depending on your OS.
    var.paths: ["/var/log/nginx/error.log"]

*********




filebeat modules enable tomcat

cd /etc/filebeat/modules.d
nano tomcat.yml
===========
- module: tomcat
  # Access logs
  access:
    enabled: true

    # Set custom paths for the log files. If left empty,
    # Filebeat will choose the paths depending on your OS.
    var.paths: ["/var/log/nginx/access.log"]

  # Error logs
  error:
    enabled: true

    # Set custom paths for the log files. If left empty,
    # Filebeat will choose the paths depending on your OS.
    var.paths: ["/var/log/nginx/error.log"]

*********


filebeat test output

filebeat setup


#Elk-public-ip:5601

#Explore on my own → 




