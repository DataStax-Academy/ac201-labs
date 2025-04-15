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
The Linux `fuser` command returns the PID of the process that *owns* a specific port/protocol.

✅  Get the PIDS for nodeA and nodeB 
```
fuser 9043/tcp
fuser 9044/tcp
```{{exec}}