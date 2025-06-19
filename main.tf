terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# 🔐 Clave SSH
resource "digitalocean_ssh_key" "chamba_key" {
  name       = "chambaApp"
  public_key = file("${path.module}/keys/chambaApp.pub")
}

# 💻 Droplet
resource "digitalocean_droplet" "chamba_server" {
  name       = "chamba-server"
  region     = "sfo3"
  size       = "s-1vcpu-2gb"
  image      = "ubuntu-24-04-x64"
  ssh_keys   = [digitalocean_ssh_key.chamba_key.id]
  user_data  = file("${path.module}/scripts/init.sh")
}

# 🕒 Espera mientras Docker se instala
resource "time_sleep" "wait_docker" {
  depends_on      = [digitalocean_droplet.chamba_server]
  create_duration = "90s"
}

# 🚀 Despliegue de la app con Docker
resource "null_resource" "deploy_api" {
  depends_on = [time_sleep.wait_docker]

  provisioner "remote-exec" {
    inline = [
      "cd /root",
      "if [ -d ChambaApp-Back ]; then cd ChambaApp-Back && git pull; else git clone https://github.com/angx7/ChambaApp-Back.git && cd ChambaApp-Back; fi",
      "docker build -t chamba-back .",
      "docker rm -f chamba-api || true",
      "docker run -d -p 80:8080 --name chamba-api chamba-back"
    ]


    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("${path.module}/keys/chambaApp")
      host        = digitalocean_droplet.chamba_server.ipv4_address
    }
  }
}

# 📁 Proyecto ChambaApp
resource "digitalocean_project" "chamba_project" {
  name        = "ChambaApp"
  description = "Infraestructura para la API de Vapor"
  purpose     = "Web Application"
  environment = "Production"
}

# 🔗 Asociar el Droplet al proyecto
resource "digitalocean_project_resources" "chamba_resources" {
  project   = digitalocean_project.chamba_project.id
  resources = [digitalocean_droplet.chamba_server.urn]

  depends_on = [digitalocean_droplet.chamba_server]
}

# 🌍 Output de IP
output "ip_servidor" {
  value = digitalocean_droplet.chamba_server.ipv4_address
}
