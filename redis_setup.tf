resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = "${var.redis_node_type}"
  num_cache_nodes      = 1
  parameter_group_name = "${var.redis_parameter_group}"
  port                 = 6379
}

