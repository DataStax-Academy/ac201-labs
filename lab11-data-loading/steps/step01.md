In this step, you will build a table and load data.
You will use the `COPY FROM` command to puplate the table from a CSV file.

✅ Use the **Editor** tab to open a Theia window and examine `states.csv` in `/filesystem/home/cassandra-user/data/`

The CSV file contains data for Alabama - Missouri and the JSON file contains data for Montana - Wyoming.


✅ Switch back to **Tab 1**



✅ Use `cqlsh` to connect to the database
```
nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

Create a keyspace in the cluster.

✅ Create the `geography` keyspace
```
CREATE KEYSPACE geography WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
};
```{{exec}}

✅ Use the `geography` keyspace
```
USE geography;
```{{exec}}

For this lab, you will create a table of states.

✅ Create the table
```
CREATE TABLE states (
    name text PRIMARY KEY,
    abbreviation text,
    population int,
    capital text
);
```{{exec}}

Use `COPY FROM` to laoad the JSON data.

✅ Load the `geography` keyspace
```
COPY states (name, abbreviation, population, capital) 
  FROM '~/data/states.csv' WITH HEADER='true';
```{{exec}}

Since there are 50 states you should see 50 rows imported.
![loaded](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab11/loaded.jpg)

Verify that the data was loaded
✅ Display the state data
```
SELECT * FROM states;
```{{exec}}