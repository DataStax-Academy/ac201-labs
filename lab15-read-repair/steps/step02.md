In this step, you will execute a write with one server shut down. 

There are the IP/Ports for each server.

| Server | IP | Port |
| ----------- | ----------- | ----------- |
| nodeA | 172.30.1.10 | 9042 |
| nodeB | 172.30.1.11 | 9043 |
| nodeC | 172.30.1.12 | 9044 |

To explore hinted handoff, you are going to shut one server down.

✅ Use `fuser` to shut down the serverC process (port:9044)
```
fuser -k 9044/tcp
```{{exec}}

The Linux `watch` command runs a script and refreshes it at an interval you set.
You will use `watch` to run `nodetool` until nodeC is in the `Down/Normal` (`DN`) state.

✅ Use `nodetool` and `watch` to verify that nodeC (172.30.112) is shut down
```
watch -n 5 nodeA/bin/nodetool status
```{{exec}}

✅ Once nodeC has shut down use Ctrl-C stop the `watch`
```
Ctrl-C
```{{exec interrupt}}

To demonstrate read reair, you are going to insert a new item into the menu.
Since nodeC is down, the new item is only stored on nodeA and nodeB.

✅ Insert the Corvette
```
nodeA/bin/cqlsh 172.30.1.10 
  -e "INSERT INTO restaurant.menu(id, item, price) 
      values(1004, 'Paella', 24.50);"
```{{exec}}

✅ Verify that Paella is in the table
```
nodeA/bin/cqlsh 172.30.1.10  -e "SELECT * FROM restaurant.menu;"
```{{exec}}