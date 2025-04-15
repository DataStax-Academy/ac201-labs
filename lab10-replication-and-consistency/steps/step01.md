In this step, you will start a three-node Cassandra cluster and create a table.

| Server | IP | Port |
| ----------- | ----------- | ----------- |
| nodeA | 172.30.1.10 | 9042 |
| nodeB | 172.30.1.11 | 9043 |
| nodeC | 172.30.1.12 | 9044 |

✅ Start the three servers 
```
nodeA/bin/cassandra > /dev/null 2>&1 &
nodeB/bin/cassandra > /dev/null 2>&1 &
nodeC/bin/cassandra > /dev/null 2>&1 &
```{{exec}}

Use the Linux `watch` command to run `nodetool status` every five seconds to see whether all three servers have started.

✅ Use `watch` to run `nodetool status`
```
watch -n 5 nodeA/bin/nodetool status
```{{exec}}

You may see one or both of the following errors if `nodetool` tries to connect before any servers start.

![failed to connect](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/failed-to-connect.jpg)

![illegal argument](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/illegal-argument.jpg)

Since `nodetool` runs every five seconds, the errors will go away once the servers start.
Wait until all three servers are running in the Up and Normal (`UN`) state.

![cluster running](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/cluster-running.jpg)

Once all three servers are running you will open a new tab.

✅ Open a new Tab
Click on the **+** icon (next to **Tab1**) to create a new tab.
Next, click on **Tab2** to switch tabs.

✅ Change the user in **Tab2** to `cassandra-user`
```
su - cassandra-user
```{{exec}}

✅ Connect to the cluster with `cqlsh` 
```
nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

Create a keyspace in the cluster.
The keyspace will have replication factor `3` so you can experiment with consistency levels.

✅ Create the `store` keyspace
```
CREATE KEYSPACE store WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':3
};
```{{exec}}

✅ Use the `store` keyspace
```
USE store;
```{{exec}}

For this lab, you will create a customers table.

✅ Create the table
```
CREATE TABLE customers (
  id int PRIMARY KEY,
  name text
);
```{{exec}}