In this step, you will build a table with a partition key column and two clustering columns.
This table will be partitioned by cusine (type) and ordered by ratings 1-5.
You will run some queries and consider queries that this table does not support.

✅ Start by connecting to the cluster wuth `cqlsh` 
```
 /home/cassandra-user/nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

You will create the table in the 'dining' keyspace.

✅ Create the `dining` keyspace.
```
CREATE KEYSPACE dining WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
};
```{{exec}}

✅ Use the `dining` keyspace.
```
USE dining;
```{{exec}}

You should see a list of countries and the continents they are on.

✅ Create the table
```
CREATE TABLE restaurants_by_cuisine (
  cuisine text,
  rating int,
  name text,
  city text,
  PRIMARY KEY ((cuisine), rating, name)
);
```{{exec}}

✅ Populate the table
```
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Luigi''s Pizza', 'pizza', 5, 'Dallas');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Golden Wok', 'chinese', 4, 'Dallas');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Sea Breeze', 'seafood', 3, 'Dallas');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Pizza Haven', 'pizza', 2, 'Dallas');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Panda Garden', 'chinese', 5, 'Dallas');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Captain''s Catch', 'seafood', 4, 'Dallas');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Slice of Heaven', 'pizza', 3, 'Seattle');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Mandarin Express', 'chinese', 2, 'Seattle');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Neptune''s Table', 'seafood', 5, 'Seattle');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Cheesy Bites', 'pizza', 4, 'Seattle');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Dragon Palace', 'chinese', 3, 'Seattle');
INSERT INTO restaurants_by_cuisine (name, cuisine, rating, city)
  VALUES ('Ocean Delight', 'seafood', 1, 'Seattle');

```{{exec}}