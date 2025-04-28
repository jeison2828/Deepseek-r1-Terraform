variable "vpc_name" {
  type = string
}

variable "security_group_name" {
   type = string  
}

variable "ecs_name" {
   type = string
}

variable "vpc_cidr" {
   type = string
}

variable "subnet_name" {
   type = string 
}

variable "subnet_cidr" {
   type = string 
}

variable "subnet_gateway_ip" {
   type = string 
}

variable "distilled_model" {
  type = string
}

variable "dify_enable" {
  type = string
}

variable "image_name_regex" {
  type = string
}

variable "ecs_flavor" {
  type = string
}

variable "image_visibility" {
  type = string
  
}
variable "ecs_password" {
  type = string
}

variable "system_disk_size" {
  type = string
}

variable "charging_mode" {
  type = string 
}



