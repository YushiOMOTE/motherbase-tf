resource "random_string" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

provider "rancher2" {
  alias     = "bootstrap"
  api_url   = "https://${local.server_ip}:${local.rancher_port}"
  bootstrap = true
  insecure  = true
}

resource "rancher2_bootstrap" "admin" {
  provider  = rancher2.bootstrap
  password  = random_string.password.result
  telemetry = true
}

provider "rancher2" {
  alias     = "admin"
  api_url   = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure  = true
}

resource "rancher2_cluster" "cluster" {
  provider    = rancher2.admin
  name        = "cluster"
  description = "Test cluster"
  rke_config {
    network {
      plugin = "canal"
    }
  }
}
