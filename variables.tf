variable "vpc_name" {
  default = "terraform-deepseek-v1"
  description = "VPC name"

}

variable "security_group_name" {
   default = "terraform-deepseek-v1"
}

variable "ecs_name" {
   default = "deepseek-v1"
}

variable "vpc_cidr" {
   default = "172.16.0.0/16"  
}

variable "subnet_name" {
   default = "subnet-deepseek-terraform"
}

variable "subnet_cidr" {
   default = "172.16.1.0/24"
}

variable "subnet_gateway_ip" {
   default = "172.16.1.1"
}

variable "distilled_model" {
  default = "DeepSeek-R1-Distill-Qwen-7b"
}

variable "dify_enable" {
  default = "enable"
}

variable "image_name_regex" {
  default = "Ubuntu 22.04 server 64bit[0-9A-Za-z. ]+Tesla[0-9A-Za-z. ]+CUDA[0-9A-Za-z.() ]+"
  
}

variable "ecs_flavor" {
  default = "p2s.2xlarge.8"
}

variable "image_visibility" {
  default = "public"
  
}

variable "ecs_password" {
  default = "Huawei12"
}

variable "system_disk_size" {
  default = "200"
}

variable "charging_mode" {
  default = "postPaid"
}


