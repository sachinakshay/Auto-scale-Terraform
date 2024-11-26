# main.tf

provider "aws" {
  region = "us-west-2" # Replace with your preferred region
}

# Launch Template
resource "aws_launch_template" "example" {
  name_prefix          = "example-"
  image_id             = "ami-04dd23e62ed049936" # Replace with your AMI ID
  instance_type        = "t2.micro"
  key_name             = "autoscaling" # Replace with your SSH key

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = ["sg-056ae9373213c5266"] # Replace with your security group
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = ["subnet-0bb045e90acb875fc"] # Replace with your subnet ID

  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}

# Scaling Policies and CloudWatch Alarms remain unchanged.
