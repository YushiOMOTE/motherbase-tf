resource "vultr_dns_domain" "domain" {
  count     = var.reserve_ip ? 1 : 0
  domain    = var.domain
  server_ip = vultr_server.server.main_ip
}
