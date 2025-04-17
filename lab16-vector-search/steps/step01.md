✅ Use `cqlsh` to connect to the database
```
nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

Create a keyspace in the cluster.

✅ Create the `foo` keyspace
```
CREATE KEYSPACE foo WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
};
```{{exec}}

✅ Use the `foo` keyspace
```
USE foo;
```{{exec}}

For this lab, you will create a table of states.

✅ Create the table
```
CREATE TABLE bar (
    name text PRIMARY KEY,
    vals VECTOR<int,3>
);
```{{exec}}

.

✅ INSERT
```
INSERT INTO bar(name, vals) VALUES('David',[1,2,3]);
INSERT INTO bar(name, vals) VALUES('David',[1,2,3]);
```{{exec}}

✅ Display the state data
```
SELECT * FROM bar;
```{{exec}}