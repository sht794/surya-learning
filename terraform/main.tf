
resource "aws_instance" "santhosh_instance" {
  ami           = var.ami_id # Ubuntu AMI ID
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = false
  tags = {
    Name = "DevOps-Server"
  }
}

resource "aws_instance" "surya_instance" {
  ami           = var.ami_id # Ubuntu AMI ID
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = false
  tags = {
    Name = "DevOps-Server-2"
  }
}

resource "aws_instance" "surya_instance-2" {
  ami           = var.ami_id # Ubuntu AMI ID
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = false
  tags = {
    Name = "DevOps-Server-2"
  }
}

