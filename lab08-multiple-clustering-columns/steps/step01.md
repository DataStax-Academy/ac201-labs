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
  VALUES ('Roll & Go', 'sushi', 5, 4, 'Phoenix');
```{{exec}}

You should see the restaurants grouped by `cuisine`.
In addition to the grouping, the restaurants are sorted by `rating` and then `name`.

Now you can query on the clustering columns and sice they are ordered, you can do *order* or *range* queries.

✅ Find the least expensive sushi restaurant with a ratig of 5
```
 SELECT * FROM restaurants 
   WHERE cuisine='sushi' AND rating = 5  
   ORDER by cost ASC LIMIT 1;
```{{exec}}

✅ Find all the steakhouses rated 3 and above
```
ELECT * FROM restaurants 
  WHERE cuisine='steakhouse' AND rating >= 3;
```{{exec}}

✅ Find all the steakhouses rated 5 from most to least expensive
```
SELECT * FROM restaurants 
  WHERE cuisine='steakhouse' AND rating = 5 ORDER BY cost DESC;
```{{exec}}



