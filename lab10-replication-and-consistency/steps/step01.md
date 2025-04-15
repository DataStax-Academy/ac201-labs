In this step, you will start a three-node Cassandra cluster.

	| Server directory | IP | port | 
| ----------- | ----------- | ---- |
| Header | Title | AAA |
| Paragraph | Text | BBB |

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
USE league;
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

✅ Enter the week 1 scores
```
INSERT INTO scores (team, player, week, score) 
  VALUES ('SA', 'Dave', 1, 397);
INSERT INTO scores (team, player, week, score) 
  VALUES ('SA', 'Tyson', 1, 414);
INSERT INTO scores (team, player, week, score) 
  VALUES ('EP', 'Rick', 1, 404);
```{{exec}}

✅ Execute a query to retrieve all of the scores
```
SELECT * FROM scores;
```{{exec}}

✅ Enter the week 2 scores
```
INSERT INTO scores (team, player, week, score) 
  VALUES ('SA', 'Dave', 1, 442);
INSERT INTO scores (team, player, week, score) 
  VALUES ('SA', 'Tyson', 2, 430);
INSERT INTO scores (team, player, week, score) 
  VALUES ('EP', 'Rick', 2, 412);
```{{exec}}

✅ Execute a query to retrieve all of the scores
```
SELECT * FROM scores;
```{{exec}}

Take a look at the results. 
There is only one score for Dave.
There was an error in the week 2 insert statement. 
The week was set to `1` instead of '2'.
This is an example of an *upsert* in Cassandra. 
Cassandra did not reject the insert even though the primary key was lready in the database!

`INSERT INTO scores (team, player, week, score)`
`  VALUES ('SA', 'Dave', 1, 442);`

![upsert](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab09/upsert.jpg)

You can fix Dave's scores by doing an `UPDATE` for week 1 and an `INSERT` for week 2.

✅ Fix Dave's scores
```
UPDATE scores SET score = 397 
  WHERE team = 'SA' AND player = 'Dave' AND week = 1;
INSERT INTO scores (team, player, week, score) 
  VALUES ('SA', 'Dave', 2, 442);
```{{exec}}

✅ Execute a query to retrieve all of the scores
```
SELECT * FROM scores WHERE team = 'SA' AND player = 'Dave'; 
```{{exec}}

You should see Dave's scores for week 1 and week 2.

