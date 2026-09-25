# Домашнее задание к занятию 5. «Практическое применение Docker» — Часть 2

## Задача 0
* Старый `docker-compose` отсутствует, плагин `docker compose` установлен (версия **2.40.3**).

![Проверка версий Docker](./task0_docker_version_check.png)

## Задача 1
Создан многоэтапный `Dockerfile.python` на базе `python:3.12-slim`. Сборка и тегирование (`test-python-app:latest`) прошли успешно.

**Лог успешного тестирования сборки:**
```text
Step 10/12 : COPY . .
 ---> 34f3d9f4b983
Step 11/12 : EXPOSE 5000
 ---> Running in cfce63cb9c6b
 ---> Removed intermediate container cfce63cb9c6b
 ---> d59fd170c5c0
Step 12/12 : CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
 ---> Running in f96d94ec6162
 ---> Removed intermediate container f96d94ec6162
 ---> e2ebd5b2d286
Successfully built e2ebd5b2d286
Successfully tagged test-python-app:latest
```

## Задача 2
Создан реестр `test`, образ отправлен в реестр и просканирован на уязвимости (найдено: high:44, medium:53, low:57).

**Отчет сканирования образа (`crpcpfra0537h7vnl3h5`):**
```text
+----------------------+----------------------+---------------------+--------+--------------------------------+

|          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
+----------------------+----------------------+---------------------+--------+--------------------------------+

| che2snkqoq9kib48hfds | crpcpfra0537h7vnl3h5 | 2026-09-25 06:43:21 | READY  | high:44, medium:53, low:57,    |
|                      |                      |                     |        | undefined:2                    |
+----------------------+----------------------+---------------------+--------+--------------------------------+
```

## Задача 3
Работа проверена через `curl`, логи записаны в MySQL.

![Локальный SQL запрос в базу данных](./task3_mysql_query_result.png)

## Задача 4
Написан bash-скрипт `deploy.sh`, проект развернут в `/opt/shvirtd-example-python`.

![SQL запрос с внешними IP адресами Check-Host](./task4_production_mysql_result.png)

## Задача 5
Написан скрипт `backup.sh` с использованием `schnitzler/mysqldump` и динамической загрузкой секретов из `.env`. Настроен cron-task.

![Ротация резервных копий в каталоге backup](./task5_cron_backups.png)

## Задача 6
Слои проанализированы через `dive`, файл скопирован на локальную машину. Полные данные и логи можно найти в исходных материалах.

![Анализ слоев образа через утилиту dive](./task6_dive_analysis.png)
