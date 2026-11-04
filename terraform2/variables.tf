variable "project_name" {
  type        = string
  default     = "netology"
  description = "Название проекта для генерации имен"
}

variable "environment" {
  type        = string
  default     = "develop"
  description = "Окружение (стэнд) для генерации имен"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "Базовое имя VPC сети"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "Зона доступности для web-платформы"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "Зона доступности для базы данных"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "CIDR для подсети web"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "CIDR для подсети db"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство операционной системы"
}

# Единая map-переменная со всеми параметрами ресурсов виртуальных машин
variable "vms_resources" {
  type = map(object({
    cores          = number
    memory         = number
    core_fraction  = number
    boot_disk_size = number
    platform_id    = string
    preemptible    = bool
    nat            = bool
  }))
  default = {
    web = {
      cores          = 2
      memory         = 1
      core_fraction  = 5
      boot_disk_size = 10
      platform_id    = "standard-v2"
      preemptible    = true
      nat            = true
    }
    db = {
      cores          = 2
      memory         = 2
      core_fraction  = 20
      boot_disk_size = 20
      platform_id    = "standard-v2"
      preemptible    = true
      nat            = true
    }
  }
}

# Общая переменная метаданных (Задание 6)
variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ..." # Замени на свой актуальный SSH-ключ, если необходимо
  }
}
