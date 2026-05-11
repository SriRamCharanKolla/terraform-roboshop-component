# Terraform Roboshop Component Module

This Terraform module is designed to deploy a specific component of the Roboshop application on AWS. It automates the process of provisioning a base instance, bootstrapping it with the application, baking a new AMI, creating an Auto Scaling Group (ASG), and registering the application with an Application Load Balancer (ALB).

## Architecture & Workflow

1. **Initial Provisioning**: Creates an initial EC2 instance based on a base CentOS/RedHat AMI fetched via data sources.
2. **Bootstrapping**: Connects to the instance via SSH and runs a local `bootstrap.sh` script to install and configure the specified component application and version.
3. **AMI Creation**: Bakes a new Amazon Machine Image (AMI) from the fully configured initial instance.
4. **Target Group & ALB Configuration**: Creates an ALB Target Group and a Listener Rule to route traffic to the component based on host headers.
5. **Auto Scaling**: Provisions a Launch Template with the new AMI and an Auto Scaling Group to manage application instances.
6. **Scaling Policy**: Applies a Target Tracking Scaling Policy based on CPU utilization (target 70.0%) to handle load.
7. **Cleanup**: Terminates the initial provisioning instance using a local-exec provisioner once the ASG and policies are in place.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `component` | The name of the Roboshop component (e.g., `frontend`, `catalogue`, `user`) | `string` | n/a | yes |
| `rule_priority` | The priority for the ALB listener rule | `number` | n/a | yes |
| `project` | The project name | `string` | `"roboshop"` | no |
| `environment` | The environment name (e.g., `dev`, `prod`) | `string` | `"dev"` | no |
| `app_version` | The application version to deploy | `string` | `"v3"` | no |
| `domain_name` | The domain name used for the application | `string` | `"aitechapp.fun"` | no |

## Data Sources

This module relies on AWS Systems Manager (SSM) Parameter Store to fetch existing infrastructure details dynamically:
- VPC ID (`/${var.project}/${var.environment}/vpc_id`)
- Private Subnet IDs (`/${var.project}/${var.environment}/private_subnet_ids`)
- Security Group ID for the component (`/${var.project}/${var.environment}/${var.component}_sg_id`)
- ALB Listener ARNs for Frontend (`/${var.project}/${var.environment}/frontend_alb_listener_arn`) and Backend (`/${var.project}/${var.environment}/backend_alb_listener_arn`)

## Requirements

- Terraform version matching your infrastructure baseline.
- AWS Provider configured.
- Existing VPC, subnets, ALBs, and security groups properly configured and stored in SSM Parameter Store matching the naming conventions.
- A `bootstrap.sh` script must be present in the directory where this module is invoked (it executes via `provisioner "file"`).