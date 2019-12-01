output "kube" {
  value = {
    host     = local.server_ip
    password = random_string.password.result
    url      = "https://${local.server_ip}:${local.rancher_port}"
  }
}
