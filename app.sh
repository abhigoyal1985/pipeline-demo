
#!/bin/bash
sudo setenforce 0
sudo yum install wget vim telnet nmap zip unzip -y

echo "Install Java JDK 8"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk

sudo mkdir -p /mnt/artefact
sudo chmod 777 /mnt/artefact
