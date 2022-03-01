#9090 --> Prometheus Server
#9100 --> Prometheus Node Exporter
#3000 --> Grafana

#launch amazon linux --> t2.medium --> Sg → 22 my ip, 9090 anywhere, 3000 anywhere, 9100 anywhere

#prometheus install
sudo su -
#Create a system user for Prometheus
useradd --no-create-home --shell /bin/false prometheus
#Create the directories in which we will be storing our configuration files and libraries
mkdir /etc/prometheus
mkdir /var/lib/prometheus
#Set the ownership of the /var/lib/prometheus directory
chown prometheus:prometheus /var/lib/prometheus
cd /tmp/
#Download prometheus using wget command(prometheus website : https://prometheus.io/download/#prometheus)
wget https://github.com/prometheus/prometheus/releases/download/v2.34.0-rc.0/prometheus-2.34.0-rc.0.linux-amd64.tar.gz
#Extract the files using tar
tar -xvf prometheus-2.34.0-rc.0.linux-amd64.tar.gz
#You need to inside prometheus-2.34.0-rc.0.linux-amd64/
cd prometheus-2.34.0-rc.0.linux-amd64/
#Move the configuration file and set the owner to the prometheus user
mv console* /etc/prometheus
mv prometheus.yml /etc/prometheus
chown -R prometheus:prometheus /etc/prometheus
#Move the binaries and set the owner
mv prometheus /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus
#Create the prometheus service file
nano /etc/systemd/system/prometheus.service
#Add the below line
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries
[Install]
WantedBy=multi-user.target

###################

#Reload systemd
systemctl daemon-reload
#Enable Prometheus service
systemctl enable prometheus
#Start Prometheus service
systemctl start prometheus
#status
systemctl status prometheus

#Now Prometheus service is ready to run and we can access it from any web browser
#<prometheus_public_ip>:9090

#Check prometheus job up or not
#status → target
cd







#grafana install
#update system
yum update -y
#Add a new file to your YUM repo
nano /etc/yum.repos.d/grafana.repo
#Add the below line
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt

###################

#install grafana
yum install grafana -y
#Reload systemd
systemctl daemon-reload
#enable grafana server
systemctl enable grafana-server.service
#start the grafana server
systemctl start grafana-server
#status
systemctl status grafana-server

#Now Grafana service is ready to run and we can access it from any web browser
#<publicip>:3000

#see default user name and password
#Username : admin
#Password : admin

#configure prometheus as grafana datasource
#Grafana UI → settings → configuration → Add Data Source → prometheus (select) 

# http Url :http://18.118.109.94:9090/
# Save Test







#node_exporter install
cd /tmp
##Download node_exporter using wget command(prometheus website : https://prometheus.io/download/#node_exporter)
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
#extract the file
tar xvzf node_exporter-1.3.1.linux-amd64.tar.gz
#move the binary files of node_exporter to /usr/local/bin
mv node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/
#create a node_exporter user to run the node_exporter service
useradd -rs /bin/false node_exporter
#create a custom node exporter service
#create a node_exporter.service file in the /etc/systemd/system directory
nano /etc/systemd/system/node_exporter.service
#Add the below line
[Unit]
Description=Node Exporter
After=network.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target

#################

#Reload systemd
systemctl daemon-reload
#enable node_exporter
systemctl enable node_exporter
#start
systemctl start node_exporter
#status
systemctl status node_exporter

#SSH into prometheus machine and open the prometheus.yml file
#which is at location /etc/prometheus/
nano /etc/prometheus/prometheus.yml
#copy jobname : prometheus and paste last
#change name & ip & port
  - job_name: "Node_Exporter"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["18.117.232.94:9100"]

#################

#restart prometheus server
systemctl restart prometheus

#prometheus UI
#Check prometheus job up or not
#status → target

#Check prometheus job up or not
#Prometheus dashboard → up → execute


#Grafana UI
#Grafana UI → + (select) → import

#import via grafana.com :  14513  → load

#Prometheus : prometheus(default) → import


