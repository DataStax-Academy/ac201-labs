In this step you will shut down some of the servers in the cluster and observe the effect on reads and writes at different consistency levels.

Remember consistency level is the number of nodes that need to acknowlege (ACK) a request for it to succeed.
Cassandra will *always* attempt to write to the number of nodes specified in the *replication factor*.
Cassandra will *only* attempt to read from the number of nodes required to satisfy the *consistency level*.

✅ Use the `CONSISTENCY` command to determine the current consistency level
```
CONSISTENCY;
```{{exec}}

You should see that the level is `ONE`.

You can also use `CONSISTENCY` to set consistency levels.
Next, you are going to insert some data into the table at these consistency levels: 


| Consistency Level | Description |
| ----------- | ----------- |
| `ONE` | 1 node |
| `LOCAL_QUORUM` | Equivalent to `TWO` with replication factor `3` |
| ALL` | Equivalent to `THREE` with replication factor `3` |

✅ Insert the data
```
CONSISTENCY ONE;
INSERT INTO customers( id, name ) VALUES(1, 'Jie' );

CONSISTENCY LOCAL_QUORUM;
INSERT INTO customers( id, name ) VALUES(2, 'Raha' );

CONSISTENCY ALL;
INSERT INTO customers( id, name ) VALUES(3, 'Charlie' );
```{{exec}}

The current consistency level is `ALL` (you set it before you inserted Charlie).
Try retrieving all the rows from the table.

✅ Insert the data
```
SELECT * FROM customers;
```{{exec}}

You should see all the data. 
The behavior is more interesting when some of the servers are not running.
Next you are going to shut down two of the servers.

✅ Open a new Tab

Click on the **+** icon (next to **Tab2**) to create a new tab.
Next, click on **Tab3** to switch tabs.

Because they all the servers are running on the same virtual machine, you will need to find their process ids (PID). 
The Linux `fuser -k` command kills the process that *owns* a specific port/protocol. 

✅  Kill nodeB(9043) and nodeC(9044) 
```
fuser -k 9043/tcp
fuser -k 9044/tcp
```{{exec}}

✅ Switch to Tab1

Click on the **Tab1**

Nodetool should still be running. 
You should see that the servers at `172.30.1.11`(nodeB) and `172.30.1.12`(nodeC) are in the **DN** state.
Server `172.30.1.11`(nodeA) should still be in the **UN** state.
(You might have to wait a bit since the command only runs every 5 seconds.)

![nodeB and nodeC are down](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/two-down.jpg)

✅ Switch to Tab2

Click on the **Tab2**

You should still be in the `cqlsh` shell.

You are going try to insert three new customers into the table at the consistency levels you used before.

✅ Insert Tal at consistency level `ONE`
```
CONSISTENCY ONE;
INSERT INTO customers( id, name ) VALUES(4, 'Tal' );
```{{exec}}

This `INSERT` succeded because there is one node (nodeA) still running. 
Cassandra tried to satisfy the replication factor and write to all three nodes, but only one node had to *ACK* to for the write to succeed.

✅ Insert Ariel at consistency level `LOCAL_QUORUM`
```
CONSISTENCY LOCAL_QUORUM;
INSERT INTO customers( id, name ) VALUES(5, 'Ariel' );
```{{exec}}

This `INSERT` failed becuse `LOCAL_QUORUM` for replication factor `3` is two and only one node was available.

![LOCAL_QUORUM](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/local-quorum.jpg)

✅ Insert Kalani at consistency level `ALL`
```
CONSISTENCY ALL;
INSERT INTO customers( id, name ) VALUES(6, 'Kalani' );
```{{exec}}

This `INSERT` failed becuse `ALL` for replication factor `3` is three and only one node was available.

![ALL](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/all.jpg)

Run a query to see what data is actually in the table

✅ Retrieve all the data
```
SELECT * FROM customers;
```{{exec}}

The `SELECT` failed!
It failed because the consistency level is still `ALL`.
That requires as many nodes as the replication factor (3) to ACK.
Since there is only one node it fails,

Set the consistency level to `ONE` and try again.

✅ Set the consistency level to `ONE` and retrieve all the data
```
CONSISTENCY ONE;
SELECT * FROM customers;
```{{exec}}

You should see the original 3 customers(Jie, Raha, and Charlie) plus Tal.

![4 customers](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/four.jpg)

You are going to restart nodeB and nodeC and see what data is in the database.

✅ Switch to Tab3

Click on the **Tab3**

✅ Start nodeB and nodeC as `cassandra-user`
```
su - cassandra-user -c 'nodeB/bin/cassandra > /dev/null 2>&1 &'
su - cassandra-user -c 'nodeC/bin/cassandra > /dev/null 2>&1 &'
```{{exec}}

Wait for the servers to start.

✅ Switch to Tab1

Click on the **Tab1**

Wait until all three servers are in the `UN` state.

✅ Switch to Tab2

Click on the **Tab2**

You should still be in the `cqlsh` shell.
Set the consistency level to `ALL` and retrieve all the data.

✅ Retrieve the data
```
CONSISTENCY ALL;
SELECT * FROM customers;
```{{exec}}

You should see the same 4 customers as before.
Ariel and Kalani were never written to the database because there were not enough servers to meet the consistency level.

![4 customers](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/four.jpg)