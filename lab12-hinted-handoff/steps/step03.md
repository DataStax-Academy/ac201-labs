In this step you will restart nodeC then you will shut down nodeA and nodeB.
Next, you will connect to nodeC and see if the hinted handoff propogated the newly-added data.

✅ Restart nodeC
```
nodeC/bin/cassandra -R > nodeC/logs/cassandra.log 2>&1 &
```{{exec}}

The Linux `watch` command runs a script and refreshes it at an interval you set.
You will use `watch` to run `nodetool` until nodeC is in the `UN` state.

✅ Restart nodeC
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

Use `nodetool` to verify that nodeC (172.30.112) is the only node running.
Since nodeA is shutting give nodetool nodeC's IP address so it can connect.

✅ Check server status
```
~/nodeA/bin/nodetool -h 172.30.112 -p 9044 status
```{{exec}}