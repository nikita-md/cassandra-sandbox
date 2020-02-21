tracing on;

DESCRIBE keyspaces;
DESCRIBE keyspace tech_talk;

use tech_talk;

-- partition 1
INSERT INTO tech_talk.posts (author_id, body, type, uuid) VALUES (1, 'some text 1', 0, 11153456346);
INSERT INTO tech_talk.posts (author_id, body, type, uuid) VALUES (1, 'some text 2', 1, 11153456347);

-- partition 2
INSERT INTO tech_talk.posts (author_id, body, type, uuid) VALUES (2, 'some text 3', 0, 11153456348);
INSERT INTO tech_talk.posts (author_id, body, type, uuid) VALUES (2, 'some text 4', 1, 11153456349);
INSERT INTO tech_talk.posts (author_id, body, type, uuid) VALUES (2, 'some text 5', 0, 11153456350);

SELECT token(author_id), author_id FROM posts;

SELECT * FROM posts WHERE author_id = 1 AND type = 0; -- NO
SELECT * FROM posts WHERE author_id = 1 AND uuid =11153456346 AND type = 0; -- YES

SELECT * FROM posts WHERE uuid = 11153456346 AND type = 0; -- NO
SELECT * FROM posts WHERE uuid = 11153456346 AND type = 0 ALLOW FILTERING; -- NO

SELECT * FROM posts_by_type WHERE author_id = 1 AND type = 0; -- YES

DELETE FROM posts WHERE author_id = 1 AND uuid = 11153456346;

UPDATE posts SET reposters_ids = [3] WHERE author_id = 1 AND uuid = 11153456346 AND type = 0;
UPDATE posts SET reposters_ids = [3] + reposters_ids WHERE author_id = 1 AND uuid = 11153456346 AND type = 0;
UPDATE posts SET reposters_ids = reposters_ids + [4] WHERE author_id = 1 AND uuid = 11153456346 AND type = 0;
UPDATE posts SET reposters_ids[0] = 0 WHERE author_id = 1 AND uuid = 11153456346 AND type = 0;
UPDATE posts SET tags = {'news', 'cassandra'} WHERE author_id = 1 AND uuid = 11153456346 AND type = 0;
UPDATE posts SET tags = tags - {'news'} WHERE author_id = 1 AND uuid = 11153456346 AND type = 0;
UPDATE posts SET tags = tags + {'ruby'} WHERE author_id = 1 AND uuid = 11153456346 AND type = 0;


SELECT * FROM posts_counters;
UPDATE posts_counters SET likes = likes + 1 WHERE author_id = 1 AND post_uuid = 11153456346;
UPDATE posts_counters SET likes = likes - 1 WHERE author_id = 1 AND post_uuid = 11153456346;
