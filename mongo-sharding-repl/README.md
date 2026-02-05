# MongoDB Sharding + Replication

## Архитектура

Вариант 2: шардирование с репликацией. 2 шарда, по 3 реплики в каждом.

Компоненты:
- `configSrv` - Config Server
- `shard1-1, shard1-2, shard1-3` - первый шард (replica set)
- `shard2-1, shard2-2, shard2-3` - второй шард (replica set)
- `mongos` - роутер
- `pymongo_api` - приложение

## Запуск

```shell
docker compose up -d
```

```shell
bash ./scripts/init-replication.sh
```

## Проверка

Приложение: http://localhost:8080

Статус:
```bash
docker compose exec -T mongos mongosh --eval "sh.status()"
```
