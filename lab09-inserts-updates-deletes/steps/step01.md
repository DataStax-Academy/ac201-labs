In this step, you will build a table with a partition key column and three clustering columns.

✅ Start by connecting to the cluster with `cqlsh` 
```
 /home/cassandra-user/nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

You will create the table in the 'dining' keyspace.

✅ Create the `league` keyspace.
```
CREATE KEYSPACE league WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
};
```{{exec}}

✅ Use the `league` keyspace.
```
USE dining;
```{{exec}}

This table track scores for a sports league.
There is a partition for each team. 
The player (first name) and week (1-8) are clustering columns.
Score is an int between 0-450.

<strong>Note:</strong> You cannot constraint the column values in Cassandra. 
Even though scores should be between 0 and 450, Cassandra will not enforce the limits.
Likewise only primary key columns are required


✅ Create the table
```
CREATE TABLE scores (
  team text,
  player text,
  week int,
  score int,
  PRIMARY KEY ((team), player, week)
);
```{{exec}}

✅ Populate the table
```
INSERT INTO scores (team, player, week score) 
  VALUES ('SA', 'Dave', 1, 397 )
```{{exec}}
