In this step, you will use `cqlsh` to create a keyspace and a table.
Then, you will populate the table and performa simle query.

✅ Use `cqlsh` to connect to Cassandra
```
~/nodeA/bin/cqlsh 172.30.10
```{{exec}}

You will need to create a keyspace for this lab.

✅ Use `cqlsh` to create a keyspace
```
CREATE KEYSPACE world WITH replication = {
  'class':'NetwrokTopologyStrategy',
  'datacenter1':1
};
```{{exec}}

✅ Use the keyspace you created
```
use world;
```{{exec}}

Next you will create a table.
The table will contain country names and the continents there they are located.

✅ Create the table
```
CREATE TABLE countries {
  id int PRIMARY KEY,
  continent text,
  country text
}
```{{exec}}

✅ Create the table
```
INSERT INTO countries (id, continent, country) VALUES (1, 'Africa', 'Nigeria');
INSERT INTO countries (id, continent, country) VALUES (2, 'Africa', 'South Africa');
INSERT INTO countries (id, continent, country) VALUES (3, 'Asia', 'China');
INSERT INTO countries (id, continent, country) VALUES (4, 'Asia', 'India');
INSERT INTO countries (id, continent, country) VALUES (5, 'Europe', 'Germany');
INSERT INTO countries (id, continent, country) VALUES (6, 'Europe', 'France');
INSERT INTO countries (id, continent, country) VALUES (7, 'North America', 'United States');
INSERT INTO countries (id, continent, country) VALUES (8, 'North America', 'Canada');
INSERT INTO countries (id, continent, country) VALUES (9, 'South America', 'Brazil');
INSERT INTO countries (id, continent, country) VALUES (10, 'South America', 'Argentina');
```{{exec}}

✅ Select all countries
```
SELECT * from coiuntries;
```{{exec}}
