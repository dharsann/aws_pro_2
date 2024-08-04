resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "prod-subnet-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2a"
  tags = {
    Name = "prod-subnet-public-1"
  }
}

resource "aws_ig" "prod-igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "prod-igw"
  }
}

resource "aws_instance" "sftp-server" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = "mumbai-region-key-pair"
  subnet_id     = aws_subnet.prod-subnet-public-1.id  
  security_groups = [aws_security_group.sftp-sg.id]
  user_data = file("/home/dharsann/terraform/aws_pro_1/script.sh")
  tags = {
    Name = "sftp-server"
  }
}


resource "aws_eip" "eip" {
  instance = aws_instance.sftp-server.id
}