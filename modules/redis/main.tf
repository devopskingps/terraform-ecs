resource "aws_elasticache_cluster" "cluster" {
  cluster_id           = var.cluster_id
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = "default.redis6.x"
  engine_version       = var.engine_version
  port                 = 6379
  security_group_ids   = [aws_security_group.cluster.id]
  subnet_group_name    = aws_elasticache_subnet_group.cluster.name
}

resource "aws_elasticache_subnet_group" "cluster" {
  name       = "${var.cluster_id}"
  subnet_ids = var.private_subnets
}

resource "aws_security_group" "cluster" {
  name        = "${var.cluster_id}"
  description = "Redis instances for ${var.cluster_id}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_id}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

