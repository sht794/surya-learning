data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.environment}-${var.project_name}"]
  }
}
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name   = "tag:Name"
    values = ["subnet-private-*"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name   = "tag:Name"
    values = ["subnet-public-*"]
  }
}

resource "aws_security_group" "python_server_sg" {
  name        = "python-server-sg-${var.environment}-${var.project_name}"
  description = "Security group for Python server"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["13.233.177.0/29"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "python_server_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.18-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "python_server" {
  ami           = data.aws_ami.python_server_ami.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.public.ids[0]
  vpc_security_group_ids = [aws_security_group.python_server_sg.id]
  key_name      = "surya"
  user_data    = file("${path.module}/script/userdata.sh")

  tags = {
    Name = "ec2-${var.environment}-${var.project_name}"
  }
}