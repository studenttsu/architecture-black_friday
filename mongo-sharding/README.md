# MongoDB Sharding

## Архитектура

Вариант 1: шардирование с 2 шардами без репликации.

Компоненты:
- `configSrv` - Config Server
- `shard1` - первый шард
- `shard2` - второй шард
- `mongos` - роутер
- `pymongo_api` - приложение

## Запуск

Запустить контейнеры:

```shell
docker compose up -d
```

Инициализировать кластер:

```shell
bash ./scripts/init-sharding.sh
```

## Проверка

Приложение: http://localhost:8080

Статус шардов:
```bash
docker compose exec -T mongos mongosh --eval "sh.status()"
```
