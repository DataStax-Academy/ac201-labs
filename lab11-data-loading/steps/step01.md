In this step, you will build a table and load data.
You will use the `COPY FROM` command to puplate the table from a CSV and a JSON file.

✅ Use the **Editor** tab to open a Theia window and examine `states.csv` and `states.json` in `/filesystem/home/cassandra-user/data/`

The CSV file contains data for Alabama - Missouri and the JSON file contains data for Montana - Wyoming.


✅ Switch back to **Tab 1**



✅ Use `cqlsh` to connect to the databse
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
    population integer,
    capital text
);
```{{exec}}

Use `COPY FROM` to laoad the JSON data.

✅ Use the `geography` keyspace
```
COPY states FROM '~/data/states.json';
```{{exec}}

Verify that the data was loaded
✅ Display the state data
```
SELECT * FROM states;
```{{exec}}