In this step, you will create and populate a table 

✅ Use `nodetool` to verify that the cluster is running.
```
~/nodeA/bin/nodetool status
```{{exec}}

You should see all three servers running in the `UN` state.

✅ Use `cqlsh` to connect to the database
```
nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

Create a keyspace in the cluster.

✅ Create the `restaurant` keyspace
```
CREATE KEYSPACE restaurant WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
};
```{{exec}}

✅ Use the `restaurant` keyspace
```
USE restaurant;
```{{exec}}

For this lab, you will create a table of members.

✅ Create the table
```
CREATE TABLE menu (
  id int PRIMARY KEY,
  item text,
  price decimal
);
```{{exec}}


✅ Insert a couple of items into the table
```
INSERT INTO menu (id, item, price) VALUES (1001, 'steak', 35.99);
INSERT INTO menu (id, item, price) VALUES (1002, 'salmon', 25.99);
INSERT INTO menu (id, item, price) VALUES (1003, 'ribs', 24.50);
```{{exec}}

✅ View the data from the table
```
SELECT * FROM menu;
```{{exec}}

✅ Quit `cqlsh`
```
exit
```{{exec interrupt}}

