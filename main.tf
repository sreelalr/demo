terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws-profile
}

resource "aws_key_pair" "terraform-keys" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDRn/vLCWaOHKnq3LpM4t5A4BcN7C6RJKWElrRUKHvmEMHAo3Ga95cGofjOfKXO0cOB62Ip2k2rP2U24WC8D/jlfzBXL4MVK4mSs4JYHuixWrIF+VfD2WYi6qO1djLqtdx+u3voFd6yYUZ2uQSZAFW1L1yLUZobvZLa32h7FhjdKxWQEXt0fx1fdM+CRsuiL1lCfEAERXmuKKAGvW9LbANfvRyB+kL83HnO7LU8aTdKsZ5Z4eu09DY0tgUCrZLE2lONdEWcCgumjSXoNTQqzC2vdCjwKzrETaOYkDd+EHvkNlBCTlz9PWYU9v1BZgfq4X9rnidwicGee2WWmCqD8QCjTt1gC8q0bgRkuYNpRKwsdppJ25qWJpbqMnDzcIYSdRq/ZBtPaBbWSxVEuGtjTa9r2560l0UIqYBnNHQmhdycnheG9hDjsF0qhyshy3S2bMBf/pd1+RLs5ne5BWFP8Kn5K55PjCxyRqRQhwhlXaR9xEzCkqFDZwNh3wXi+gfvivk= sreelal@vivobook"
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.terraform-keys.key_name
  security_groups = [aws_security_group.jenkins_sg.name]
  user_data       = file("install_jenkins.sh")
  tags = {
    Name = "Jenkins"
  }
}