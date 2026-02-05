#!/bin/bash

sleep 10

# Config Server
docker compose exec -T configSrv mongosh <<EOF
rs.initiate({
  _id: "configReplSet",
  configsvr: true,
  members: [{ _id: 0, host: "configSrv:27017" }]
})
EOF

sleep 5

# Shard 1
docker compose exec -T shard1 mongosh <<EOF
rs.initiate({
  _id: "shard1",
  members: [{ _id: 0, host: "shard1:27017" }]
})
EOF

sleep 5

# Shard 2
docker compose exec -T shard2 mongosh <<EOF
rs.initiate({
  _id: "shard2",
  members: [{ _id: 0, host: "shard2:27017" }]
})
EOF

sleep 10

# Добавление шардов
docker compose exec -T mongos mongosh <<EOF
sh.addShard("shard1/shard1:27017")
sh.addShard("shard2/shard2:27017")
EOF

sleep 5

# Включение шардирования
docker compose exec -T mongos mongosh <<EOF
sh.enableSharding("somedb")
EOF

sleep 2

# Создание коллекции и данные
docker compose exec -T mongos mongosh <<EOF
use somedb
sh.shardCollection("somedb.helloDoc", { "name": "hashed" })
for(var i = 0; i < 1000; i++) {
  db.helloDoc.insertOne({age: i, name: "ly" + i})
}
EOF
