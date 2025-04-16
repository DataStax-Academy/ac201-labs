In this step you will look at the `data` directories before and after flushing the memtable.

Because you created the `cars` keyspace the `nodea/data/data` directory has an subdirectory for the `inventory` table.

✅ Click on the **Editor** tab and navigate to `/filesystem/home/cassandra-user-nodeA/data/data'

You should see a subdirectory for the table called `inventory-SOME_UUID`

![editor](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab13/editor.jpg)

✅ Open `inventory-SOME_UUID` to verify that it is empty

✅ Click on **Tab1** and return to the bash shell

The data you wrote to the `inventory` table is in the memtable and commit log.
Cassandra will flush the memtable to SSTables when the memtable gets full or when you exlicitly use `nodetool flush`.

✅ Flush the memtable
```
nodeA/bin/nodetool flush
```{{exec}}

✅ Click on the **Editor** tab

You should see the SSTable and other data files

![SSTables](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab13/sstables.jpg)