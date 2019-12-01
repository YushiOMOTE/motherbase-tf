variable api_key {}

variable region_id {
  default = 25
}

variable system {
  default = "motherbase"
}

variable domain {
  default = "yushiomote.org"
}

variable cloud_config {
  default = "https://raw.githubusercontent.com/YushiOMOTE/motherbase/master/terraform/components/server/templates/cloud-config.yml"
}

variable reserve_ip {
  default = false
}

variable ports {
  default = {
    http = {
      protocol = "tcp"
      network  = "0.0.0.0/0"
      port     = 80
    }
    https = {
      protocol = "tcp"
      network  = "0.0.0.0/0"
      port     = 443
    }
    app = {
      protocol = "tcp"
      network  = "0.0.0.0/0"
      port     = 8080
    }
    rancher = {
      protocol = "tcp"
      network  = "0.0.0.0/0"
      port     = 10443
    }
    ssh = {
      protocol = "tcp"
      network  = "0.0.0.0/0"
      port     = 22
    }
  }
}
