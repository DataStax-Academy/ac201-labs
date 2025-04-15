In this step, you will build a table with a partition key column and three clustering columns.

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
Cassandra will use the `rating` and `cost` columns to order the rows in the partition.
Values for `rating` and `cost` are 1-5, with 5 being the highest.
The `name` column is primarily for uniqueness.

✅ Create the table
```
CREATE TABLE restaurants (
  cuisine text,
  rating int,
  cost int,
  name text,
  city text,
  PRIMARY KEY ((cuisine), rating, cost, name)
);
```{{exec}}

✅ Populate the table
```
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Prime Cut', 'steakhouse', 5, 4, 'New York');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Sakura Sushi', 'sushi', 4, 3, 'New York');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('The Beef House', 'steakhouse', 3, 5, 'New York');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Tokyo Bites', 'sushi', 5, 5, 'New York');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Grill & Flame', 'steakhouse', 4, 2, 'New York');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Wasabi World', 'sushi', 2, 1, 'New York');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Desert Steakhouse', 'steakhouse', 5, 3, 'Phoenix');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Sushi Zen', 'sushi', 3, 2, 'Phoenix');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Cactus Grill', 'steakhouse', 2, 1, 'Phoenix');
INSERT INTO restaurants (name, cuisine, rating, cost, city)
  VALUES ('Samurai Sushi', 'sushi', 4, 5, 'Phoenix');
INSERT INTO restaurants (name, cuisine, rating, cost, city)

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