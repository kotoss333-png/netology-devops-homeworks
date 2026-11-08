# --- Переменные авторизации Yandex Cloud ---

variable "cloud_id" {
  type        = string
  default     = "b1gxxxxxxxxxxxxxxxx" 
  description = "https://yandex.ru"
}

variable "folder_id" {
  type        = string
  default     = "b1gxxxxxxxxxxxxxxxx" 
  description = "https://yandex.ru"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default zone for provider"
}

variable "service_account_key_file" {
  type        = string
  default     = "./authorized_key.json" 
  description = "Path to Yandex Cloud service account key file"
}


# --- Переменные для locals (Именования) ---

variable "project_name" {
  type        = string
  default     = "netology"
  description = "Project prefix for resource naming"
}

variable "environment" {
  type        = string
  default     = "develop"
  description = "Infrastructure environment stage"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


# --- Сетевые настройки и зоны доступности серверов ---

# Возвращаем default_cidr, так как его запрашивает main.tf для первой подсети
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "Subnet CIDR for Web VM (develop)"
}

variable "vm_web_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone for Web VM"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "Zone for DB VM"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "Subnet CIDR for DB VM"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Yandex Cloud image family"
}


# --- Комплексная переменная вычислительных ресурсов ВМ ---

variable "vms_resources" {
  type = map(object({
    cores          = number
    memory         = number
    core_fraction  = number
    platform_id    = string
    preemptible    = bool
    nat            = bool
    boot_disk_size = number # Добавили обязательный параметр размера диска
  }))
  
  default = {
    web = {
      cores          = 2
      memory         = 2
      core_fraction  = 5
      platform_id    = "standard-v3"
      preemptible    = true
      nat            = true
      boot_disk_size = 10 # Размер диска для web в ГБ
    },
    db = {
      cores          = 2
      memory         = 2
      core_fraction  = 5
      platform_id    = "standard-v3"
      preemptible    = true
      nat            = false
      boot_disk_size = 20 # Размер диска для db в ГБ (исправляет ошибку Unsupported attribute)
    }
  }
}


# --- Общие метаданные для всех ВМ ---
# Меняем тип на простую карту map(string), чтобы main.tf принял его без ошибок типа

variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ..." # Подставьте сюда ваш публичный ключ
  }
}

variable "token" {
  type        = string
  default     = null
  description = "OAuth-token for Yandex Cloud (from personal.auto.tfvars)"
}