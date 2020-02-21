#!/bin/bash

cqlsh cassandra --execute=<<CQL
  USE tech_talk;

  DROP MATERIALIZED VIEW IF EXISTS posts_by_type;
  DROP MATERIALIZED VIEW IF EXISTS posts_by_author_and_type;
  DROP TABLE IF EXISTS posts;
  DROP TABLE IF EXISTS posts_counters;

  CREATE TABLE posts (
    author_id bigint,
    uuid bigint,
    type int,
    body text,
    reposters_ids list<bigint>,
    tags set<text>,
    PRIMARY KEY ((author_id), uuid, type)
  ) WITH CLUSTERING ORDER BY (uuid DESC, type ASC);

  CREATE TABLE posts_counters (
    author_id bigint,
    post_uuid bigint,
    likes counter,
    PRIMARY KEY ((author_id), post_uuid)
  ) WITH CLUSTERING ORDER BY (post_uuid DESC);

  CREATE MATERIALIZED VIEW posts_by_type AS
  SELECT
    author_id,
    uuid,
    type,
    body
  FROM posts
  WHERE uuid IS NOT NULL
    AND author_id IS NOT NULL
    AND type IS NOT NULL
  PRIMARY KEY ((type), author_id, uuid)
  WITH CLUSTERING ORDER BY (author_id DESC, uuid DESC);

  CREATE MATERIALIZED VIEW posts_by_author_and_type AS
  SELECT
    author_id,
    uuid,
    type,
    body
  FROM posts
  WHERE uuid IS NOT NULL
    AND author_id IS NOT NULL
    AND type IS NOT NULL
    AND body IS NOT NULL
  PRIMARY KEY ((author_id, type), uuid, body)
  WITH CLUSTERING ORDER BY (uuid DESC, body ASC);
CQL
