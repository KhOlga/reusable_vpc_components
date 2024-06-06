resource "aws_instance" "ec2-instance" {
  for_each = var.instances

  vpc_security_group_ids = each.key == "public" ? [local.pub_sg_id] : [local.pr_sg_id]
  subnet_id              = each.key == "public" ? local.pub_sub_id : local.pr_sub_id

  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  availability_zone           = each.value.availability_zone
  associate_public_ip_address = each.value.associate_public_ip_address
  user_data                   = each.value.user_data

  tags = {
    Name = each.value.ec2_name
  }
}

locals {
  pub_sub_id = aws_subnet.subnet["public_subnet"].id
  pr_sub_id  = aws_subnet.subnet["private_subnet"].id

  pub_sg_id = aws_security_group.public_security_group.id
  pr_sg_id  = aws_security_group.private_security_group.id
}
