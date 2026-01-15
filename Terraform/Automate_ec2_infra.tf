provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "demo_vpc"
    }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
    tags = {
        Name = "demo_igw"
    }
}
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet1"
    }
}
resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet2"
    }       
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
    tags = {
        Name = "private_subnet1"
    }       
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
    tags = {
        Name = "private_subnet2"
    }       
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }     
    tags = {
        Name = "public_rt"
    }       
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_eip" "nat_eip1" {
  domain = "vpc"
    tags = {
        Name = "nat_eip1"
    }       
}

resource "aws_nat_gateway" "nat_gw1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id     = aws_subnet.public_subnet1.id
    tags = {
        Name = "nat_gw1"
    }       
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw1.id
  }     
    tags = {
        Name = "private_rt"
    }   
}

resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rt.id
}
output "public_subnet_ids" {
  value = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
}   
output "private_subnet_ids" {
  value = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}

resource "aws_security_group" "load_balancer_sg" {
  name        = "lb_sg"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
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
}

resource "aws_security_group" "ec2_sg" {
  name        = "web_sg"
  description = "Allow load balancer traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80    
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]
    }

    egress {    
    from_port   = 0
    to_port     = 0     
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web_server" {
  ami           = "ami-0ecb62995f68bb549" # Amazon Ubuntu AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "WebServer1"
  }
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "Hello from Web Server 1" > /var/www/html/index.html
              EOF
}

resource "aws_instance" "web_server2" {
  ami           = "ami-0ecb62995f68bb549" # Amazon Ubuntu AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet2.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "WebServer2"
  }
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "Hello from Web Server 2" > /var/www/html/index.html
              EOF
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "app_tg"
  }
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.web_server.id
  port             = 80
  
}

resource "aws_lb_target_group_attachment" "tg-attach2" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.web_server2.id
  port             = 80
}

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  depends_on         = [aws_lb_target_group_attachment.tg-attach, aws_lb_target_group_attachment.tg-attach2]

  tags = {
    Name = "app_lb"
  }
}

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
}
