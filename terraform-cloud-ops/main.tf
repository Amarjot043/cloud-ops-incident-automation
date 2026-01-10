
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# ----------------------------
# Security Group allowing SSH for admin access
# and HTTP for public web traffic
# ----------------------------
resource "aws_security_group" "cloud_ops_sg" {
  name        = "cloud-ops-sg"
  description = "Allow SSH and HTTP access"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["45.115.187.82/32"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-ops-security-group"
  }
}

# ----------------------------
# EC2 Instance
# ----------------------------
resource "aws_instance" "cloud_ops_ec2" {
  ami           = "ami-00ca570c1b6d79f36"
  instance_type = "t3.micro"
  key_name      = "aws-practice-key"

  vpc_security_group_ids = [aws_security_group.cloud_ops_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "terraform-cloud-ops-ec2"
  }
}

# ----------------------------
# Output
# ----------------------------
output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.cloud_ops_ec2.public_ip
}
