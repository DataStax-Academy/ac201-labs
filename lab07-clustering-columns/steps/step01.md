In this step, you will build a table with a partition key column and two clustering columns.
Since this table has multiple clustering columns, partitions may contain more than one row.

✅ Start by connecting to the cluster with `cqlsh` 
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

The 'restaurants' table will be partitioned or grouped by `cuisine`. 

✅ Create the table
```
CREATE TABLE restaurants (
  cuisine text,
  rating int,
  name text,
  city text,
  PRIMARY KEY ((cuisine), rating, name)
);
```{{exec}}

✅ Populate the table
```
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Luigi''s Pizza', 'pizza', 5, 'Dallas');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Golden Wok', 'chinese', 4, 'Dallas');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Sea Breeze', 'seafood', 3, 'Dallas');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Pizza Haven', 'pizza', 2, 'Dallas');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Panda Garden', 'chinese', 5, 'Dallas');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Captain''s Catch', 'seafood', 4, 'Dallas');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Slice of Heaven', 'pizza', 3, 'Seattle');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Mandarin Express', 'chinese', 2, 'Seattle');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Neptune''s Table', 'seafood', 5, 'Seattle');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Cheesy Bites', 'pizza', 4, 'Seattle');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Dragon Palace', 'chinese', 3, 'Seattle');
INSERT INTO restaurants (name, cuisine, rating, city)
  VALUES ('Ocean Delight', 'seafood', 1, 'Seattle');
```{{exec}}

You should see the restaurants grouped by `cuisine`.
In addition to the grouping, the restaurants are sorted by `rating` and then `name`.

Now you can query on the clustering columns and sice they are ordered, you can do *order* or *range* queries.

✅ Find the top rated pizza restaurant (remember *5* is the highest rating)
```
SELECT * FROM restaurants WHERE cuisine='pizza' ORDER BY rating DESC LIMIT 1;
```{{exec}}

✅ Find the two lowest rated the seafood restaurants
```
SELECT * FROM restaurants WHERE cuisine='seafood' LIMIT 2;
```{{exec}}

✅ Find all the Chinese restaurants with 2, 3 or 4 ratings
```
SELECT * FROM restaurants WHERE cuisine='seafood' AND rating >= 1 AND rating <= 4 ;
```{{exec}}


✅ Find the best seafood restaurants in Seattle
```
SELECT * FROM restaurants WHERE city='Seattle' AND cuisine='seafood' AND rating=5;
```{{exec}}

That query failed because `city` is not a primary key column.
To enable querying on non-primary key columns, Cassandra 5.0 introduced Storage-Attached Indexing (SAI). 
Use SAI to create indexes on non-primary key columns and facilitate efficient `WHERE` clause filtering.