drop KEYSPACE mykeyspace ;
CREATE KEYSPACE mykeyspace WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor' : 1 };
use mykeyspace;
CREATE TABLE users ( user_id int PRIMARY KEY, fname text,lname text );
INSERT INTO users (user_id, fname, lname)  VALUES (1744, 'john', 'doe'); 
INSERT INTO users (user_id, fname, lname)  VALUES (1746, 'john', 'smith');
INSERT INTO users (user_id,  fname, lname) VALUES (1745, 'john', 'smith');
select * from users;


