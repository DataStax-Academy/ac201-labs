In this step you will shut down some of the servers in the cluster and observe the effect on reads and writes at different consistency levels.

Remember consistency level is the number of nodes that need to acknowlege (ACK) a request for it to succeed.
Cassandra will *always* attempt to write to the number of nodes sepcified in the *replication factor*.
Cassandra will *only* attempt to read from the numnber of nodes required to satisfy the *consistency leel*.

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
| 'LOCAL_QUORUM' | Equivalent to `TWO` with replication factor `3` |
| 'ALL' | Equivalent to `THREE` with replication factor `3` |

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
Try retriving all the rows from the table.

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
The Linux `fuser -k` command returns kills the process that *owns* a specific port/protocol. 

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

![nodeB and nodeC are down](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/two-down.jpg)

✅ Switch to Tab1
Click on the **Tab1**

You should still be in the `cqlsh` shell.

You are going try to insert three new customers into the table at the consistency levels you used before.

✅ Insert Tal and consistency level `ONE`
```
CONSISTENCY ONE;
INSERT INTO customers( id, name ) VALUES(1, 'Tal' );
```{{exec}}

This `INSERT` succeded because there is one node (nodaA) still running. 
Cassandra tried to satisfy the replication factor and write to all three nodes, but only one node had to *ACK* to for the write to succeed.

✅ Insert Ariel at consistency level `LOCAL_QUORUM`
```
CONSISTENCY LOCAL_QUORUM;
INSERT INTO customers( id, name ) VALUES(2, 'Ariel' );
```{{exec}}

This `INSERT` failed becuse `LOCAL_QUORUM` for replication factor `3` is two and only one node was available.

![LOCAL_QUORUM](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/local-quorum.jpg)

✅ Insert Kalani at consistency level `ALL`
```
CONSISTENCY ALL;
INSERT INTO customers( id, name ) VALUES(3, 'Kalani' );
```{{exec}}

This `INSERT` failed becuse `ALL` for replication factor `3` is three and only one node was available.

![ALL](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab10/all.jpg)

Run a query to see what data is actually in the table

✅ Retrieve all the data
```
SELECT * FROM customers;
```{{exec}}