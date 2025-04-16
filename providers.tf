terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "1.72.3"
    }
  }
}

provider "huaweicloud" {
  region     = "la-south-2"  
  access_key = "your AK"  
  secret_key = "your SK"  
}