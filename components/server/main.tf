data "template_file" "startup" {
  template = file("templates/startup.ipxe")
  vars = {
    cloud_config = var.cloud_config
  }
}

provider "vultr" {
  api_key = var.api_key
}

resource "vultr_startup_script" "startup" {
  name   = "${var.system}-${terraform.workspace} startup script"
  type   = "pxe"
  script = data.template_file.startup.rendered
}

resource "vultr_server" "server" {
  plan_id           = 201
  os_id             = 159
  region_id         = var.region_id
  script_id         = vultr_startup_script.startup.id
  label             = "${var.system}-${terraform.workspace}"
  tag               = "${var.system}-${terraform.workspace}"
  hostname          = "${var.system}-${terraform.workspace}"
  network_ids       = [vultr_network.network.id]
  firewall_group_id = vultr_firewall_group.firewall.id
}

resource "vultr_reserved_ip" "reserved_ip" {
  count       = var.reserve_ip ? 1 : 0
  label       = "${var.system}-ip"
  region_id   = var.region_id
  ip_type     = "v4"
  attached_id = vultr_server.server.id
}
