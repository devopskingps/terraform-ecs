output "alb_frontend_dns" {
  value = aws_alb.alb-frontend.dns_name
}

output "alb_backend_dns" {
  value = aws_alb.alb-backend_alb.dns_name
}

output "alb_backend" {
  value = aws_alb_listener.backend.arn
}

output "alb_frontend" {
  value = aws_alb_listener.frontend.arn
}

output "frontend-tg_arn" {
  value = aws_alb_target_group.frontend-tg.arn
}

output "backend-tg_arn" {
  value = aws_alb_target_group.backend-tg.arn
}

output "postgres-tg_arn" {
  value = aws_alb_target_group.postgres-tg.arn
}


output "alb-frontend-sg_id" {
  value = aws_security_group.alb-frontend-sg.id
}

output "alb-backend-sg_id" {
  value = aws_security_group.alb-backend-sg.id
}