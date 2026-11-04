resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = "${var.vpc_name}-d"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-d2"
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

# Первая ВМ (web) с использованием конфигурации из vms_resources
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name_local
  platform_id = var.vms_resources.web.platform_id

  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vms_resources.web.boot_disk_size
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources.web.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.web.nat
  }

  metadata = var.metadata
}

# Вторая ВМ (db) с использованием конфигурации из vms_resources
resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name_local
  platform_id = var.vms_resources.db.platform_id
  zone        = var.vm_db_zone

  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vms_resources.db.boot_disk_size
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources.db.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vms_resources.db.nat
  }

  metadata = var.metadata
}
