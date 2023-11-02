resource "aws_security_group" "web_sg" {
  for_each = var.web
  name = "${var.env}-${each.key}-service-sg"
  description = "web security group for ${each.key}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${each.key}-service-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "security_sg" {
  for_each = var.security
  name = "${var.env}-${each.key}-service-sg"
  description = "web security group for ${each.key}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${each.key}-service-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "adaptor_sg" {
  for_each = var.adaptor
  name = "${var.env}-${each.key}-service-sg"
  description = "web security group for ${each.key}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${each.key}-service-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "wrapper_sg" {
  for_each = var.wrapper
  name = "${var.env}-${each.key}-service-sg"
  description = "web security group for ${each.key}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${each.key}-service-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "validation_sg" {
  for_each = var.validation
  name = "${var.env}-${each.key}-service-sg"
  description = "web security group for ${each.key}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${each.key}-service-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "testmvc_sg" {
  for_each = var.testmvc
  name = "${var.env}-${each.key}-service-sg"
  description = "web security group for ${each.key}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${each.key}-service-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "utility_sg" {
  for_each = var.utility
  name = "${var.env}-${each.key}-service-sg"
  description = "web security group for ${each.key}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${each.key}-service-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



resource "aws_security_group" "job_sg" {
  for_each = var.jobs
  name = "${var.env}-${each.key}-service-sg"
  description = "web security group for ${each.key}"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${each.key}-service-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}


