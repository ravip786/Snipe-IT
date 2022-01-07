  /*
  */
    resource "aws_instance" "snipe-instance" {
      ami             = "${var.ami}"
      instance_type    = "${var.instance_type}"
      key_name        = "${var.key_name}"
      #vpc_id          = "${aws_vpc.development-vpc.id}"
      vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_snipe.id}"]
      subnet_id          = "${aws_subnet.public-subnet-1.id}"
      #name            = "${var.name}"
    

    associate_public_ip_address = true
    tags = {
      Name = "snipe-Instance"
    }
  }

  resource "aws_security_group" "sg_allow_ssh_snipe" {
    name        = "allow_ssh_snipe"
    description = "Allow SSH and  snipe inbound traffic"
    vpc_id      = "${aws_vpc.development-vpc.id}"

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port   = 8080
      to_port     = 8080
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
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }
  }
/*
  output "snipe_ip_address" {
    value = "${aws_instance.snipe-instance.snipe_dns}"
  } */
