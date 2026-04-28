# data "aws_ami" "openvpn" {
#   most_recent      = true
#   owners           = ["679593333241"]

#   filter {
#     name   = "name"
#     values = ["OpenVPN Access Server Community Image-8fbe3379-*"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

data "aws_ami" "joindevops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "sg_id" {
    name = "/${var.project}/${var.environment}/_sg_id"
}

data "aws_ssm_parameter" "backend_alb_listener_arn" {
    name = "/${var.project}/${var.environment}/backend_alb_listener_arn"
}

data "aws_ssm_parameter" "frontend_alb_listener_arn" {
    name = "/${var.project}/${var.environment}/frontend_alb_listener_arn"
}