locals {
  # Интерполяция для сборки имен ВМ из переменных проекта
  vm_web_name_local = "netology-${var.vpc_name}-platform-web"
  vm_db_name_local  = "netology-${var.vpc_name}-platform-db"
}
