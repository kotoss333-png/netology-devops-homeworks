#!/bin/bash
set -e

# Автоматически определяем путь к папке проекта
PROJECT_DIR="/opt/shvirtd-example-python"
BACKUP_DIR="/opt/backup"

# Проверяем наличие файла .env, чтобы безопасно прочитать секреты
if [ ! -f "$PROJECT_DIR/.env" ]; then
    echo "Ошибка: Файл .env не найден в $PROJECT_DIR"
    exit 1
fi

# Безопасно загружаем переменные окружения из .env, игнорируя кавычки
export $(grep -v '^#' "$PROJECT_DIR/.env" | xargs)

# Генерируем уникальное имя файла с текущей датой и временем
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="mysql_backup_${TIMESTAMP}.sql"

# Создаем папку для бэкапов, если её ещё нет
sudo mkdir -p "$BACKUP_DIR"

# Запуск контейнера mysqldump с ЯВНЫМ переопределением точки входа entrypoint
docker run --rm \
  --network shvirtd-example-python_backend \
  --entrypoint mysqldump \
  schnitzler/mysqldump \
  --no-tablespaces \
  --host=db \
  --user="${MYSQL_USER}" \
  --password="${MYSQL_PASSWORD}" \
  "${MYSQL_DATABASE}" > "${BACKUP_DIR}/${BACKUP_FILE}"

echo "Резервная копия успешно создана: ${BACKUP_DIR}/${BACKUP_FILE}"
