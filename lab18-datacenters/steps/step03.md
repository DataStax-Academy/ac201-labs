In this step you will restart nodeC then you will shut down nodeA and nodeB.
Next, you will connect to nodeC and see if the hinted handoff propogated the newly-added data.

✅ Restart nodeC
```
nodeC/bin/cassandra -R > nodeC/logs/cassandra.log 2>&1 &
```{{exec}}

Use `watch` to run `nodetool` until nodeC is in the `UN` state.

✅ Wait for nodeC to start
```
watch -n 5 nodeA/bin/nodetool status
```{{exec}}

✅ Once nodeC has started use Ctrl-C stop the `watch`
```
Ctrl-C
```{{exec interrupt}}

The next step is to shut down nodeA and nodeB. 
Use `fuser` and the server port numbers to shut them down.

✅ Stop nodeA and nodeB
```
fuser -k 9042/tcp
fuser -k 9043/tcp
```{{exec interrupt}}

Use `nodetool` to verify that nodeC (172.30.1.12) is the only node running.
Since nodeA is shutting down, you will run `nodetool` from nodeC's homw directory.

✅ Wait for nodeA and nodeB to shut down
```
watch -n 5 nodeC/bin/nodetool status
```{{exec}}

You should see that only nodeC is in the `UN` state.

![only nodeC](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab12/only-nodec.jpg)

✅ Once nodeA and nodeB have shut down use Ctrl-C stop the `watch`
```
Ctrl-C
```{{exec interrupt}}


✅ Connnect to nodeC with `cqlsh`
```
~/nodeC/bin/cqlsh 172.30.1.12 9044
```{{exec}}

✅ Execute a query to find the Corvette by id (1008)
```
SELECT * FROM cars.inventory WHERE id = 1008;
```{{exec}}

![vette](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab12/vette.jpg)

You added the Corvette when only nodeA and nodeB were running.
Because nodeC was not running, the coordinator (nodeA) kept a hint to update nodeC.
Then you re-started nodeC and nodeA passed on the hint.
Finally you shut down nodeA and nodeB.
The query you just ran found the Corvette on nodeC proving that the hinted handoff succeeded.
