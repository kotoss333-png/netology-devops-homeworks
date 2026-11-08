# 3.1. Создаем 3 виртуальных диска по 1 Гб каждый
resource "yandex_compute_disk" "storage_disks" {
  count = 3

  name = "disk-${count.index + 1}"
  type = "network-hdd"
  size = 1
  zone = var.default_zone
}

# 3.2. Создаем одиночную виртуальную машину storage
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v2"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 10
      type     = "network-hdd"
    }
  }

  # 3.3. Динамически подключаем созданные выше диски через for_each
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks[*].id
    content {
      disk_id = secondary_disk.value
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  scheduling_policy {
    preemptible = true # Прерываемая для экономии
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_key}"
  }
}
