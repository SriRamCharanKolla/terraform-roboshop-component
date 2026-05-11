variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "component" {
    type = string
}

variable "app_version" {
    type = string
    default = "v3"
}

variable "rule_priority" {
    type = number
}

# variable "domain_name" {
#   default = "aitechapp.fun"
# }

variable "domain_name" {
  default = "ramcharankola.in"
}