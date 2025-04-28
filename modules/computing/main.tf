locals {
  parameter_quantity = lower(split("-", var.distilled_model)[4])
}


data "huaweicloud_images_image" "Ubuntu" {
  name_regex = var.image_name_regex
  flavor_id = var.ecs_flavor
  visibility = var.image_visibility
}

resource "huaweicloud_vpc" "vpc" {
  name = var.ecs_name
  cidr = var.vpc_cidr
}


resource "huaweicloud_vpc_subnet" "subnet" {
  name = var.subnet_name
  cidr = var.subnet_cidr
  gateway_ip = var.subnet_gateway_ip
  vpc_id = "${huaweicloud_vpc.vpc.id}"
}
resource "huaweicloud_networking_secgroup" "secgroup" {
  name        = "${var.vpc_name}-secgroup"
  description = "Security group for Ollama and Dify"
}

resource "huaweicloud_networking_secgroup_rule" "allowping" {
  security_group_id= "${huaweicloud_networking_secgroup.secgroup.id}"
  description= "Allow the ping command to test the connectivity of the Flexus Cloud Server X instance"
  direction= "ingress"
  ethertype= "IPv4"
  protocol= "icmp"
  remote_ip_prefix= "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "ollama" {
  security_group_id= "${huaweicloud_networking_secgroup.secgroup.id}"
  description= "Default port for Ollama API"
  direction= "ingress"
  ethertype= "IPv4"
  protocol= "tcp"
  ports= 11434
  remote_ip_prefix= "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "dify" {
  count= var.dify_enable == "enable" ? 1 : 0
  security_group_id= "${huaweicloud_networking_secgroup.secgroup.id}"
  description= "Default port for Dify web application"
  direction= "ingress"
  ethertype= "IPv4"
  protocol= "tcp"
  ports= 80
  remote_ip_prefix= "0.0.0.0/0"
}

resource "huaweicloud_vpc_eip" "vpc_eip" {
  name           = "${var.vpc_name}-eip"
  charging_mode  = var.charging_mode

  bandwidth {
    name        = "${var.vpc_name}-bandwidth"
    share_type  = "PER"
    size        = 300
    charge_mode = "traffic"
  }

  publicip {
    type = "5_bgp"
  }
}


resource "huaweicloud_compute_instance" "compute_instance" {
  name= "${var.ecs_name}"
  image_id= "${data.huaweicloud_images_image.Ubuntu.id}"
  flavor_id= "${var.ecs_flavor}"
  security_group_ids= [huaweicloud_networking_secgroup.secgroup.id]
  system_disk_type= "GPSSD"
  system_disk_size= var.system_disk_size
  admin_pass= var.ecs_password
  delete_disks_on_termination= true
  network {uuid = huaweicloud_vpc_subnet.subnet.id}
  agent_list= "hss,ces"
  eip_id= huaweicloud_vpc_eip.vpc_eip.id
  charging_mode= "${var.charging_mode}"
  tags= {
                    app= "DeepSeek-GPU"
                }
                user_data= "#!/bin/bash\necho 'root:${var.ecs_password}' | chpasswd\nwget -P /home/ https://deepseek-gpu.obs.la-south-2.myhuaweicloud.com/solution-as-code-module/ollama-gpu_LATAM.sh\nsh /home/ollama-gpu_LATAM.sh ${local.parameter_quantity} ${var.dify_enable} &> /home/ollama-gpu.log\nrm -rf /home/ollama-gpu_LATAM.sh"
}

