output "bastion-sg_id" {
  value = aws_security_group.ec2_bastion_sg.id
}


output "bastion_instance_id" {
  value = aws_launch_configuration.bastion.id
}