output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ingress_az1_id" {
  value = aws_subnet.subnet_ingress_az1.id
}

output "subnet_ingress_az2_id" {
  value = aws_subnet.subnet_ingress_az2.id
}

output "subnet_dmz_az1_id" {
  value = aws_subnet.subnet_dmz_az1.id
}

output "subnet_dmz_az2_id" {
  value = aws_subnet.subnet_dmz_az2.id
}

output "subnet_priv_az1_id" {
  value = aws_subnet.subnet_priv_az1.id
}

output "subnet_priv_az2_id" {
  value = aws_subnet.subnet_priv_az2.id
}
