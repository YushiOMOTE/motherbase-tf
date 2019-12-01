resource "vultr_network" "network" {
  description = "${var.system}-${terraform.workspace} private network"
  region_id   = var.region_id
  cidr_block  = "10.0.0.0/24"
}
