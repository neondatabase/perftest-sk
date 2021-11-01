terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "safekeepers" {
  count = 3
  tags = {
    Name = "perftest_safekeeper_${count.index + 1}"
  }

  ami                         = "ami-05ad4ed7f9c48178b" #debian-10-amd64-20210721-710
  instance_type               = "i3.large"
  key_name                    = "perftest"
  subnet_id                   = "subnet-07e498251a08efe65"
  monitoring                  = false
  associate_public_ip_address = true
}

resource "aws_instance" "compute" {
  tags = {
    Name = "perftest_compute"
  }

  ami                         = "ami-05ad4ed7f9c48178b" #debian-10-amd64-20210721-710
  instance_type               = "i3.large"
  key_name                    = "perftest"
  subnet_id                   = "subnet-07e498251a08efe65"
  monitoring                  = false
  associate_public_ip_address = true
}

output "safekeepers_ips" {
  value = join("\n", [for node in aws_instance.safekeepers : format("%s private_ip=%s", node.public_ip, node.private_ip)])
}

output "compute_ips" {
  value = format("%s private_ip=%s", aws_instance.compute.public_ip, aws_instance.compute.private_ip)
}
