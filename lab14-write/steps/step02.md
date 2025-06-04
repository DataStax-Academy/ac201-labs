In this step you will look at the `data` directories before and after flushing the memtable.

Because you created the `cars` keyspace the `nodeA/data/data` directory has a subdirectory for the `cars` keyspace.
The `cars` directory has a subdirectory for the `inventory` table.

✅ View the `cars` directory
```
ls -l  nodeA/data/data/cars
```{{exec}}

You should see a subdirectory for the table called `inventory-SOME_UUID`

✅ Verify that `inventory-SOME_UUID` is empty
```
ls -l  nodeA/data/data/cars/inventory-*
```{{exec}}


✅ Flush the memtable
```
nodeA/bin/nodetool flush
```{{exec}}

✅ View the directory again
```
ls -l  nodeA/data/data/cars/inventory-*
```{{exec}}
You should see the SSTable and other data files

![SSTables](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab13/sstables.jpg)


After you inserted the data, the `nodeA/data/data/cars/inventory-*` directory was empty because all of the data was in the memtable and commit logs.
When you flushed the memtable, the SSTables (and other files) were created and stored on disk.