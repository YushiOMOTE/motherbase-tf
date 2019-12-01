module "server" {
  source    = "../../modules/state"
  name      = "server"
  workspace = terraform.workspace
}

locals {
  server_ip    = module.server.outputs.server.ip
  rancher_port = module.server.outputs.server.ports.rancher.port
}
