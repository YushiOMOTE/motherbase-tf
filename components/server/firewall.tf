resource "vultr_firewall_group" "firewall" {
  description = "${var.system}-${terraform.workspace} firewall"
}

resource "vultr_firewall_rule" "fw_ports" {
  firewall_group_id = vultr_firewall_group.firewall.id

  for_each = var.ports

  protocol  = each.value.protocol
  network   = each.value.network
  from_port = each.value.port
}
