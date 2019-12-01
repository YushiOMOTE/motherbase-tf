output "server" {
  value = {
    ip    = vultr_server.server.main_ip
    ports = var.ports
  }
}
