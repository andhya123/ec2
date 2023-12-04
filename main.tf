provider "aws" {
  region = "us-east-1"

}
data "aws_availability_zones" "available" {}

resource "aws_instance" "my-test-instance" {
  count = var.ec2_count
  ami = "ami-0230bd60aa48260c6"
  instance_type = var.instance_type
  key_name = var.ec2_keypair
  vpc_security_group_ids = ["${var.security_group.ec2_sg.id}"]
  subnet_id = element(var.subnets, count.index) 

  tags = {
    Name = "${var.environment}.${var.product}-${count.index}"
  }
}
