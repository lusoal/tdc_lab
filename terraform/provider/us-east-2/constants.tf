output "aws_region" {
  value = "us-east-2"
}

output "public_subnets" {
  value = ["subnet-0816a34c54ff2a23d", "subnet-0fb46caf22976a8bd"]
}

output "private_subnets" {
  value = ["subnet-062c662e62552f697", "subnet-09ffb1fe4645705cb"]
}


#Pegar VPC ID com Data
output "vpc_id" {
  value = "vpc-0cb37b128f9c9e3c4"
}

