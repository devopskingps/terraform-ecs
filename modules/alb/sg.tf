resource "aws_security_group" "alb-frontend-sg" {
  name        = "alb-frontend-sg"
  description = "controls access to the frontend ALB"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-alb-frontend-sg"
  }

}


resource "aws_security_group" "alb-backend-sg" {
  name        = "alb-backend-sg"
  description = "controls access to the backend ALB"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    #cidr_blocks = ["3.9.87.77/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["18.135.251.191/32","51.145.100.132/32", "20.117.91.125/32", "51.149.8.0/24"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-alb-backend-sg"
  }
}


