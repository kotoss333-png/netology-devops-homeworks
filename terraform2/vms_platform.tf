### Семейство образов
variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

### Задание 6: Единая map-переменная для ресурсов обеих ВМ
variable "vms_resources" {
  type = map(object({
    cores          = number
    memory         = number
    core_fraction  = number
    boot_disk_size = number
  }))
  default = {
    web = {
      cores          = 2
      memory         = 1
      core_fraction  = 5
      boot_disk_size = 5
    },
    db = {
      cores          = 2
      memory         = 2
      core_fraction  = 20
      boot_disk_size = 10
    }
  }
}

### Задание 6: Общая map-переменная для блока metadata
variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOuo5xvPI8UON/kYSpLoC5uVR5V4nATG3cwEDXyv00E9/m0+eRNQ3PVpp4nf/79sUe3W+50b4uGmoclBVcDwGqCh8VpE6fJ+3HK4UbW217uCOx3VwG4iEP1ZbbQE1zOo0Bi2izgQLwJ/sb2cewxT5maC97Q+qvJaCR4T9nqGZMSkPPcTlLSiApDIIad2fizAY+tRP8qsEhyFNBQ534flwqT3oYwbH552wKx8YaOT/Qfcj/8Q2pAUiaytvjJ/ilircX+krXGtzjqMmhzndQlTI/GnPDKczRQbnULogrx+XFpCzn2Wiya48ui45Xn57AoWlsL113fcfWIbJ5yMFBjBE/"
  }
}

### Переменные зон и сетей для базы данных
variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-d"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
}
