#!/bin/bash
set -e

# Пути автоматизации на сервере
SOURCE_DIR="$HOME/shvirtd-example-python-main"
TARGET_DIR="/opt/shvirtd-example-python"

echo "=== 1. Очистка и подготовка production-каталога $TARGET_DIR ==="
sudo rm -rf "$TARGET_DIR"
sudo mkdir -p "$TARGET_DIR"

echo "=== 2. Синхронизация файлов, скопированных с локальной машины ==="
# Копируем всё содержимое, включая скрытые файлы (.env, .dockerignore)
sudo cp -r "$SOURCE_DIR/." "$TARGET_DIR/"

echo "=== 3. Остановка старых контейнеров (если были запущены) ==="
cd "$SOURCE_DIR" && docker compose down -v || true

echo "=== 4. Запуск Docker Compose в каталоге /opt ==="
cd "$TARGET_DIR"
docker compose up -d

echo "=== 5. Проверка статуса запущенных сервисов ==="
docker ps

echo "=== Проект успешно развернут в /opt! ==="
