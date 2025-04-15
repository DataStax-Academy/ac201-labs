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

You may see errors if `nodetool` tries to connect before any servers start.
Since `nodetool` runs every five seconds, the errors will go away once the servers start.
Wait until all three servers are running in the Up and Normal (`UN`) state.

`su -cassandra-user`{{execute T2}}