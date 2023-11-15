# Resource Blocks

# Create a default VPC if one does not exist
resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "default_vpc"
  }
}

# Launch the EC2 instance and install Jenkins
resource "aws_instance" "ec2_instance" {
  ami           = var.aws_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = file("install_jenkins.sh")

  tags = {
    Name = "Jenkins server ami"
  }
}

# Create a Jenkins server security group
resource "aws_security_group" "Jenkins_Server" {
  name        = "allow_tls"
  description = "Allow access on ports 22 and 8080"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
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
    Name = "Jenkins server security group"
  }
}

# Create an S3 bucket for CD Jenkins
resource "aws_s3_bucket" "CD_Jenkins_Bucket_9_24" {
  bucket = "cd928"
}