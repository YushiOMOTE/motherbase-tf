module "server" {
  source    = "../../modules/state"
  name      = "server"
  workspace = terraform.workspace
}

locals {
  server_ip = module.server.outputs.server.ip
}
