provider "docker" {
  host = "ssh://rancher@${local.server_ip}:22"

  registry_auth {
    address     = "registry.hub.docker.com"
    config_file = pathexpand("~/.docker/config.json")
  }
}

resource "docker_volume" "site" {
  name = "site"
}

resource "docker_container" "sync" {
  image = docker_image.sync.latest
  name  = "sync"
  mounts {
    target = "/git"
    source = docker_volume.site.name
    type   = "volume"
  }
  env = [
    "SYNC_SRC=https://github.com/YushiOMOTE/motherbase-web.git",
    "SYNC_DST=/git",
    "SYNC_WAIT=10",
  ]
  restart = "always"
}

resource "docker_image" "sync" {
  name          = data.docker_registry_image.hub_sync.name
  pull_triggers = [data.docker_registry_image.hub_sync.sha256_digest]
}

data "docker_registry_image" "hub_sync" {
  name = "yushiomote/sync"
}

resource "null_resource" "nginx_setup" {
  provisioner "file" {
    source = "templates/nginx"
    destination = "/home/rancher"
    connection {
      type     = "ssh"
      user     = "rancher"
      host     = local.server_ip
    }
  }
}

resource "docker_container" "nginx" {
  depends_on = [null_resource.nginx_setup]
  image = docker_image.nginx.latest
  name  = "nginx"
  ports {
    internal = 80
    external = 80
  }
  mounts {
    target = "/git"
    source = docker_volume.site.name
    type   = "volume"
  }
  mounts {
    target = "/etc/nginx/conf.d"
    source = "/home/rancher/nginx/conf.d"
    type = "bind"
  }
  restart = "always"
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}
