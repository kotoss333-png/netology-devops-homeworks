# Динамическое формирование имен ВМ с помощью интерполяции нескольких переменных (Задание 5)
locals {
  vm_web_name_local = "${var.project_name}-${var.environment}-${var.vpc_name}-web"
  vm_db_name_local  = "${var.project_name}-${var.environment}-${var.vpc_name}-db"
}
