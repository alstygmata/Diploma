terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws"{
	region = "eu-central-1"
	access_key = "AKIASWH3ENEWPKRHCZA4"
	secret_key = "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"
}

resource "aws_instance" "ubuntu" {
  count		= 1
  ami           = "ami-0d1ddd83282187d18"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.diploma_sg.id]
  key_name      = "Frankfurt"

  user_data = file("/home/cerberus/Diploma/Bash/general_setup.sh")

  tags = {
    Name = "ubuntu-instance"
  }
}

resource "aws_instance" "a_linux" {
  ami           = "ami-00ad2436e75246bba"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.diploma_sg.id]
  key_name      = "Frankfurt"

  user_data = file("/home/cerberus/Diploma/Bash/general_setup_amazon_linux.sh")

  tags = {
    Name = "amazon-linux-instance"
  }
}


resource "aws_security_group" "diploma_sg" {
  name_prefix = "diploma-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
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
}
