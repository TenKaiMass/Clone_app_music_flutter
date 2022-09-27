# Lancement de cassandra via Docker

```bash
docker run --name mon-cassandra -p 9042:9042  -d cassandra:latest
```

puis

```
docker exec -it <shawan>
```

et on lance la commande : `cqlsh`

