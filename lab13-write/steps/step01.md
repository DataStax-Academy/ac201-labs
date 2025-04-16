In this step, you will build a table and load data.


✅ Use `cqlsh` to connect to the database
```
nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

Create a keyspace in the cluster.

✅ Create the `cars` keyspace
```
CREATE KEYSPACE cars WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
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