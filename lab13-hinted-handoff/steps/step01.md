In this step, you will create and populate a table 

✅ Use `nodetool` to verify that the cluster is running.
```
nodeA/bin/nodetool status
```{{exec}}

You should see all three servers running in the `UN` state.

✅ Use `cqlsh` to connect to the database
```
nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

Create a keyspace in the cluster.
Set the replication factor to `3`.

✅ Create the `cars` keyspace
```
CREATE KEYSPACE cars WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':3
};
```{{exec}}

✅ Use the `cars` keyspace
```
USE cars;
```{{exec}}

For this lab, you will create a table of cars.

✅ Create the table
```
CREATE TABLE inventory (
  id int PRIMARY KEY,
  make text,
  model text,
  year int
);
```{{exec}}


✅ Insert some cars into the table
```
INSERT INTO inventory(id, make, model, year) 
  values(1001, 'Dodge', 'Challenger', 1971);
INSERT INTO inventory(id, make, model, year) 
  values(1002, 'Ford',  'Mustang',    1968);
INSERT INTO inventory(id, make, model, year) 
  values(1003, 'Chevy', 'Camaro',     1969);
INSERT INTO inventory(id, make, model, year) 
  values(1004, 'Dodge', 'Daytona',    1969);
INSERT INTO inventory(id, make, model, year) 
  values(1005, 'Dodge', 'Challenger', 1972);
INSERT INTO inventory(id, make, model, year) 
  values(1006, 'Ford', ' Mustang',    1971);
INSERT INTO inventory(id, make, model, year) 
  values(1007, 'Dodge', 'Charger',    1969);
```{{exec}}

✅ View the table
```
SELECT * FROM inventory;
```{{exec}}

✅ Shut `cqlsh` down
```
exit
```{{exec}}
