# MongoDB Sharding + Replication + Cache

## Архитектура

Вариант 3: шардирование с репликацией и кешированием. 2 шарда, по 3 реплики в каждом, Redis для кеша.

Компоненты:
- `configSrv` - Config Server
- `shard1-1, shard1-2, shard1-3` - первый шард (replica set)
- `shard2-1, shard2-2, shard2-3` - второй шард (replica set)
- `mongos` - роутер
- `redis` - кеш
- `pymongo_api` - приложение

## Запуск

```shell
docker compose up -d
```

```shell
bash ./scripts/init-cache.sh
```

## Проверка

Приложение: http://localhost:8080

Кеширование работает для эндпоинта `/<collection_name>/users`

Первый запрос медленный (1 сек), повторный быстрый (из кеша)
