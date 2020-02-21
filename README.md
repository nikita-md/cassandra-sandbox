### start cassandra

* `docker-compose up`

### create a keyspace

* `docker-compose run --rm cassandra ./app/create_keyspace.sh`

### run migration

* `docker-compose run --rm cassandra ./app/migrate.sh`

### run cqlsh session

* `docker-compose run --rm cassandra cqlsh cassandra

### execute queries

```sql
cqlsh> INSERT INTO tech_talk.posts (author_id, body, type, uuid) VALUES (1, 'some text 1', 0, 11153456346);
cqlsh> SELECT * FROM posts;
```
