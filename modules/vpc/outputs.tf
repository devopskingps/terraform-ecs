output "id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [for subnet in aws_subnet.private: subnet.id]
}

output "public_1" {
  value = aws_subnet.public[0].id
}
output "public_2" {
  value = aws_subnet.public[1].id
}
output "public_3" {
  value = aws_subnet.public[2].id
}
output "private_1" {
  value = aws_subnet.private[0].id
}
output "private_2" {
  value = aws_subnet.private[1].id
}

output "private_3" {
  value = aws_subnet.private[2].id
}
output "private_subnets" {
  value = [for subnet in aws_subnet.private: subnet.id]
}

