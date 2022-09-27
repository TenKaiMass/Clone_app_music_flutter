# Lancement de cassandra via Docker

```bash
docker run --name mon-cassandra -p 9042:9042  -d cassandra:latest
```

puis se connecter à l'adresse `127.0.0.1:9042`
Si cela ne marche pas bienvenu dans mon cas...