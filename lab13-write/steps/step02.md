In this step you will look at the `data` directories before and after flushing the memtable.

Because you created the `cars` keyspace the `nodea/data/data` directory has a subdirectory the `cars` keyspace
The `cars` directory has a subdirectory for the `inventory` table.

✅ View the `cars` directory
````
ls -l  nodeA/data/data/cars
```{{exec}}

You should see a subdirectory for the table called `inventory-SOME_UUID`

![editor](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab13/editor.jpg)

✅ Verify that `inventory-SOME_UUID` is empty
````
ls -l  nodeA/data/data/cars/inventory-*
```{{exec}}


✅ Flush the memtable
```
nodeA/bin/nodetool flush
```{{exec}}

✅ View the directory again
````
ls -l  nodeA/data/data/cars/inventory-*
```{{exec}}
You should see the SSTable and other data files

![SSTables](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab13/sstables.jpg)


✅ Retrieve the data
```
nodeA/tools/bin/sstabledump \
  nodeA/data/data/club/members-*/nb-2-big-Data.db
```{{exec}}