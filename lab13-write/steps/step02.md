In this step you will look at the `data` directories before and after flushing the memtable.

Because you wrote to the `inventory` table, `nodea/data/data` directory has a `cars` subdirectory for the keyspace.


✅ Make sure the `cars` directory has been created
```
ls -l nodeA/data/data/
```{{exec}}
