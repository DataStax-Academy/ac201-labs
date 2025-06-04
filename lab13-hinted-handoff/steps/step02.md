In this step, you will execute a write with one server shut down. 

These are the IP/Port pairs for each server.

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

![nodeC down](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab12/nodeC-down.jpg)

✅ Once nodeC has shut down use Ctrl-C stop the `watch`
```
#Ctrl-C
```{{exec interrupt}}

✅ Use `cqlsh` to re-connect to the database
```
nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

✅ Use the `cars` keyspace
```
use cars;
```{{exec}}

To test hinted handoff, you are going to insert a car (a 1963 Corvette) into the database.
Since nodeC is down, the Corvette is only stored on nodeA and nodeB.

✅ Insert the Corvette
```
INSERT INTO inventory(id, make, model, year) 
  values(1008, 'Chevy', 'Corvette', 1963);
```{{exec}}

✅ Verify that the Corvette is in the table
```
SELECT * FROM inventory;
```{{exec}}

✅ Shut `cqlsh` down
```
exit
```{{exec}}