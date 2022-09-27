# Lancement de cassandra et Mongo via Docker
## Cassandra
```bash
docker run --name mon-cassandra -p 9042:9042  -d cassandra:latest
```

puis

```
docker exec -it mon-cassandra
```

et on lance la commande : `cqlsh`

## MongoDB

```
dk run -d -p 27017:27017 --name mongodb mongo
```
puis 
```
docker exec -it mongodb
```
on lance la commande `mongosh`

## Utilisation
Cassandra est un peut chiant et ressemble d'avantage a mysql, nous allons nous concentrer sur `mongodb` en esperant que celui-ci soit simple d'utilisation avec `Flutter`.

Ce qui est interressant avec `Mongo`, c'est que pour cree et ajouter une base de données c'est très simple.

il suffit de faire un fichier `.json` avec les données à l'interieur.
Une fois fait il y aura plus qu'a l'importer avec cette commande :
```
mongoimport -d <base_name> -c <collection_name> --file <mon-fichier>.json --jsonArray
```


