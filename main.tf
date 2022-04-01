provider "aws" {
  access_key = "AKIARHQRMTU7S7RPQN6G"
  secret_key = "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"
  region     = "us-east-1"
}

resource "aws_instance" "master_server" {
  ami                    = var.distro
  instance_type          = var.instance_type
  key_name               = "aws-ubuntu"
  vpc_security_group_ids = [aws_security_group.allow_connection.id]
  tags                   = merge(var.tags, { Name = "master instance" })
  user_data              = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt -y update
sudo apt  install -y docker-ce
sudo chmod 660 /var/run/docker.sock
sudo usermod -aG docker ubuntu
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt -y update
sudo apt install jenkins
sudo systemctl start jenkins
sudo usermod -aG docker jenkins
EOF
}

resource "aws_instance" "prod_server" {
  ami                    = var.distro
  instance_type          = var.instance_type
  key_name               = "aws-ubuntu"
  vpc_security_group_ids = [aws_security_group.allow_connection.id]
  tags                   = merge(var.tags, { Name = "prod instance" })
  user_data              = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt -y update
sudo apt  install -y docker-ce
sudo chmod 660 /var/run/docker.sock
sudo usermod -aG docker ubuntu
EOF
}

resource "aws_eip" "prod_server" {
  instance = aws_instance.prod_server.id
}

resource "aws_eip" "worker_server" {
  instance = aws_instance.worker_server.id
}
