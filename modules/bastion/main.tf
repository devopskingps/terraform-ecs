data "aws_ami" "ubuntu" {
   most_recent = "true"

   filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
   }

   filter {
      name = "virtualization-type"
      values = ["hvm"]
   }

   owners = ["099720109477"]
}


resource "aws_launch_configuration" "bastion" {
  name_prefix     = "Bastion-host-"
  #image_id        = data.aws_ami.ubuntu.id
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2_bastion_sg.id]
  key_name        = var.key_name

  metadata_options {
    http_tokens = "required"
  }
  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_autoscaling_group" "bastion_asg" {
  name                 = "Bastion-host"
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.bastion.name
  vpc_zone_identifier  = var.vpc_public_subnets
  target_group_arns    = var.target_group_arn_bastion

  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "ASG-Bastion"
    propagate_at_launch = true
  }

}


resource "aws_security_group" "ec2_bastion_sg" {
  name        = var.security_group_name
  description = "ec2 bastion-host security group"
  vpc_id = var.vpc_id

  tags = {
    Name = var.security_group_name
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    security_groups = [
      "${var.alb_backend_sg_id}",
    ]
    description       = "Allow all access to the bastion instance"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["18.135.251.191/32","51.145.100.132/32", "20.117.91.125/32", "51.149.8.0/24", "13.43.203.174/32"]
    description       = "Allow SSH access to the bastion instance"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


