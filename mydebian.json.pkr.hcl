packer {
  required_plugins {
    yandex = {
      version = ">= 1.1.2"
      source = "github.com/hashicorp/yandex"
    }
  }
}

source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "b1gfi3lqiknqorfdle38"
  image_description   = "my custom debian with docker"
  image_name          = "debian-12-docker"
  source_image_family = "debian-12"
  ssh_username        = "debian"
  subnet_id           = "e9b0ifh88qerl6pdto9u"
  token               = "REDACTED"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ca-certificates curl gnupg",
      "sudo install -m 0755 -d /etc/apt/keyrings",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
      "sudo chmod a+r /etc/apt/keyrings/docker.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo $VERSION_CODENAME) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin htop tmux",
      "sudo systemctl enable docker",
      "sudo systemctl start docker"
    ]
  }
}
