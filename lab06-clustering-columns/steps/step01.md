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

✅ List all the restaurants
```
SELECT * FROM restaurants;
```{{exec}}

You can use `cuisine` in 'WHERE' clauses because it is the partition key.

✅ Find all the seafood restaurants
```
SELECT * FROM restaurants WHERE cuisine='seafood';
```{{exec}}