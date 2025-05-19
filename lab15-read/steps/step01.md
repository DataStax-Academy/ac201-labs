In this step, you will put some data in SSTables and the memtable. 

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

✅ Quit `cqlsh`
```
exit
```{{exec interrupt}}

✅ Use nodetool to flush the memtable
```
nodeA/bin/nodetool flush
```{{exec interrupt}}

✅ Update the status field 
```
nodeA/bin/cqlsh 172.30.1.10 -e \
  "UPDATE club.members SET \
   status = 'gold' WHERE id = 1001;"
```{{exec}}

✅ Use nodetool to flush the memtable
```
nodeA/bin/nodetool flush
```{{exec interrupt}}

✅ Update the email field 
```
nodeA/bin/cqlsh 172.30.1.10 -e \
  "UPDATE club.members SET \
   email = 'lquinn@example.com' WHERE id = 1001;"
```{{exec}}

