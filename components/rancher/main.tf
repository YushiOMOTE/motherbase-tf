provider "docker" {
  host = "ssh://rancher@${local.server_ip}:22"
}

resource "docker_container" "rancher" {
  image = docker_image.rancher.latest
  name  = "rancher"
  ports {
    internal = 443
    external = local.rancher_port
  }
  network_mode = "bridge"
}

resource "docker_image" "rancher" {
  name = "rancher/rancher:latest"
}
