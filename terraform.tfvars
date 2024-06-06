# network values
vpc_name = "olha-vpc"
vpc_cidr = "10.0.0.0/16"

subnets = {

  public_subnet = {
    map_public_ip_on_launch = true
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "eu-west-2a"
    name                    = "olha-public-subnet"
  }

  private_subnet = {
    map_public_ip_on_launch = false
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "eu-west-2b"
    name                    = "olha-private-subnet"
  }
}

igw = "olha-igw"

public_rtb  = "olha-rtb-public"
private_rtb = "olha-rtb-private"

sg_name = {
  "public" : "olha-grp-public"
  "private" : "olha-grp-private"
}

inbound_rule = {

  allow_http_traffic = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    name        = "olha-sg-rule-allow_http"
  }

  allow_ssh_traffic = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    name        = "olha-sg-rule-allow_ssh"
  }

  allow_https_traffic = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    name        = "olha-sg-rule-allow_https"
  }
}

instances = {
  public = {
    availability_zone           = "eu-west-2a"
    associate_public_ip_address = true
    ec2_name                    = "olha-ec2-public"
    user_data                   = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install apache2 -y
        sudo systemctl start apache2
        sudo systemctl enable apache2
        echo "<html><body><h1>Hi there! This is Public Server</h1></body></html>" > /var/www/html/index.html
        EOF
  }

  private = {
    availability_zone           = "eu-west-2b"
    associate_public_ip_address = false
    ec2_name                    = "olha-ec2-private"
    user_data                   = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install apache2 -y
        sudo systemctl start apache2
        sudo systemctl enable apache2
        echo "<html><body><h1>Hi there! This is Private Server</h1></body></html>" > /var/www/html/index.html
        EOF
  }
}

#region = "eu-west-2"

#Amazon Linux
#ami_id        = "ami-06373f703eb245f45"

#Ubuntu
ami_id        = "ami-053a617c6207ecc7b"
instance_type = "t2.micro"
ssh_key_name  = "olha-sshkey"
