

#!/bin/bash
sudo setenforce 0
sudo yum install wget vim telnet nmap zip unzip -y

echo "Install Java JDK 8"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk

echo "Install Maven"
sudo yum install -y maven 

echo "Install git"
sudo yum install -y git

#echo "Install Docker engine"
#sudo yum update -y
#sudo yum install docker -y
#sudo sudo chkconfig docker on

echo "Install Jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

sudo yum install -y jenkins
#sudo usermod -a -G docker jenkins
sudo chkconfig jenkins on

echo "Start Docker & Jenkins services"
#sudo service docker start
sudo service jenkins start

sudo mkdir -p /mnt/artefact
sudo chmod 777 /mnt/artefact

## Install Ansible
sudo yum install epel-release -y
sudo yum install ansible -y

export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which java)))))
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar










