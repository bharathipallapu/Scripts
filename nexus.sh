#launch instance --> t2.medium --> nexus --> sg --> 22 anywhere , 8081 anywhere


sudo su -
cd /opt/
wget https://download.sonatype.com/nexus/3/nexus-3.37.3-02-unix.tar.gz
tar -xvzf nexus-3.37.3-02-unix.tar.gz
mv nexus-3.37.3-02 nexus
cd /opt/nexus/bin
adduser nexus
passwd nexus


visudo
-------
nexus ALL=(ALL) NOPASSWD: ALL


cd ../..
chown -R nexus:nexus nexus
chown -R nexus:nexus sonatype-work



cd /opt/nexus/bin/


vi nexus.rc
-------------
run_as_user="nexus"



cd ..
cd etc/

vi /etc/systemd/system/nexus.service
----------------------
[Unit]
Description=nexus service
After=network.target
  
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort
TimeoutSec=600
  
[Install]
WantedBy=multi-user.target



yum update -y
yum install -y java-1.8.0-openjdk-devel.x86_64
java -version

systemctl enable nexus
systemctl start nexus
systemctl status nexus




browser : <nexus_publicip>:8081


signin
-------
admin
cat /opt/sonatype-work/nexus3/admin.password

disable anonymous access