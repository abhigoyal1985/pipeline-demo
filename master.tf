provider "aws" {
	region 		= "${var.region}"
	access_key	= "${var.access}"
	secret_key	= "${var.secret}"
}


resource "aws_instance" "jenkins" {
	ami = "${lookup(var.ami, var.region)}"
	instance_type = "${var.instance-jenkins}"
	count = "${var.jenkins-count}"
	key_name      = "${var.key}"
    security_groups = ["${aws_security_group.public_sg.id}"]
	subnet_id       = "${element(aws_subnet.public_subnet.*.id, count.index + 0)}"
	root_block_device {
		volume_size = "8"
		volume_type = "gp2"
		delete_on_termination = true
	}

	provisioner "file" {
   		source      = "install.sh"
    	destination = "/tmp/install.sh"
  	}

	provisioner "file" {
   		source      = "config"
    	destination = "/tmp/"
  	}

  	provisioner "remote-exec" {
    	inline = [
	        "sudo sh /tmp/install.sh",
   	 	]
  	}

	connection {
    	user        = "centos"
		type        = "ssh"
		password    = ""
    	private_key = "${file("${var.pubkey}")}"
  	}
		tags = {
   	 		name = "demo-jenkins"
  	}
}


resource "aws_instance" "app-server" {
	ami = "${lookup(var.ami, var.region)}"
	instance_type = "${var.instance-app}"
	count = "${var.app-count}"
	key_name      = "${var.key}"
    security_groups = ["${aws_security_group.private_sg.id}"]
	subnet_id       = "${element(aws_subnet.private_subnet.*.id, count.index + 0)}"
	root_block_device {
		volume_size = "8"
		volume_type = "gp2"
		delete_on_termination = true
	}
	user_data = <<-EOF
	#!/bin/bash
	sudo setenforce 0
	sudo yum install wget vim telnet nmap zip unzip -y

	echo "Install Java JDK 8"
	sudo yum remove -y java
	sudo yum install -y java-1.8.0-openjdk
	export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which java)))))
	export PATH=$PATH:$JAVA_HOME/bin
	export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar

	sudo mkdir -p /mnt/artefact
	sudo chmod 777 /mnt/artefact
	EOF
		tags = {
   	 		name = "demo-app-server"
  	}
}

