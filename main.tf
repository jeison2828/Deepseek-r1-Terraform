module "computing" {
  source = "./modules/computing"
  vpc_name = var.vpc_name
  security_group_name = var.security_group_name
  ecs_name = var.ecs_name
  vpc_cidr = var.vpc_cidr
  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr
  subnet_gateway_ip = var.subnet_gateway_ip
  distilled_model = var.distilled_model
  dify_enable = var.dify_enable
  image_name_regex = var.image_name_regex
  ecs_flavor = var.ecs_flavor
  image_visibility = var.image_visibility
  ecs_password = var.ecs_password
  system_disk_size = var.system_disk_size
  charging_mode = var.charging_mode
  
}



