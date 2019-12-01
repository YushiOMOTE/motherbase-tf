output "rancher" {
  value = {
    ip   = local.server_ip
    port = local.rancher_port
  }
}