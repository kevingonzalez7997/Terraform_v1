# Configure the AWS provider
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}
############################# EC2 ##############################################
# Define an AWS EC2 instance
resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0fc5d935ebf8bc3bc" # Replace with your desired AMI ID
  instance_type = "t2.micro"               # Replace with your desired instance type
  vpc_security_group_ids = [aws_security_group.ec2_security.id]
  user_data = <<-EOF
    ${file("jenkin_installer.sh")}
    ${file("terraform_installer.sh")}
    ${file("vscode_installer.sh")}
EOF
  
  tags = {
    Name = "terraform-ec2"
  }
}

#################### SECURITY_GROUP ######################################
resource "aws_security_group" "ec2_security" {
  name ="ec2 security group"
  description = "ec2_sercurity_terraform"
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port = 8081
    to_port = 8081
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
