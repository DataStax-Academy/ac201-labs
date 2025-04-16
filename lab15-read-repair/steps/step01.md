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

✅ Create the `club` keyspace
```
CREATE KEYSPACE club WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
};
```{{exec}}

✅ Use the `club` keyspace
```
USE club;
```{{exec}}

For this lab, you will create a table of members.

✅ Create the table
```
CREATE TABLE members (
  id int PRIMARY KEY,
  name text,
  email text,
  status text
);
```{{exec}}


✅ Insert a member into the table
```
INSERT INTO members (id, name, email, status) 
    VALUES (1001, 'Luka Quinn', 'luka@example.com', 'silver');
```{{exec}}

✅ View the data from the table
```
SELECT * FROM members;
```{{exec}}

✅ Quit `cqlsh`
```
exit
```{{exec interrupt}}

