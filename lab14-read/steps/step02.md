In this step you will examine the SSTable files and see how a read works.

Since you flushed the memtables after the initial insert and after the update there should be two SSTable files in the `data` directory. 
That number may change after a *compaction*.
Since you only inserted a small amount of data Cassandra does need to do a compaction yet.


✅ Verify that there are two SSTables
```
ls -l nodeA/data/data/club/members-*/*big-Data.db
```{{exec}}

You should see two files: `nb-1-big-Data.db` and `nb-2-big-Data.db`. 

In the previous step, you inserted one row and updated it twice with these CQL commands:

```
INSERT INTO members (id, name, email, status) 
    VALUES (1001, 'Luka Quinn', 'luka@example.com', 'silver');

UPDATE club.members SET 
   status = 'gold' WHERE id = 1001;

UPDATE club.members SET 
   email = 'lquinn@example.com' WHERE id = 1001;
```

The data in the table should be:
| Column | Value |
| ----------- | ----------- |
| id | 1001 |
| name | Luka Quinn |
| email | lquinn@example.com |
| status | gold |


Where do these values come from?
The `sstabledump` utility exports the contents of SSTable files in JSON format
You are going to use `sstabledump` to examine the two SSTable files.

✅ Look at the contents of the older SSTable file
```
nodeA/tools/bin/sstabledump \
  nodeA/data/data/club/members-*/nb-1-big-Data.db
```{{exec}}

You should see that all the values are from the first `INSERT` you did.

✅ Look at the contents of the newer SSTable file
```
nodeA/tools/bin/sstabledump \
  nodeA/data/data/club/members-*/nb-2-big-Data.db
```{{exec}}

This file should only contain the updated `status` value - `gold`.

✅ Retrieve the data
```
nodeA/bin/cqlsh 172.30.1.10 \
  -e "SELECT * FROM club.members;"
```{{exec}}

![updated row](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab14/updated.jpg)

The query returned the expected values.
The `name` (`Luka Quinn`) came from the initial in sert and iss in the older SSTable file: `nb-1-big-Data.db`.
The `status` (`gold`)  came from the first update and is in the newer SSTable file `nb-2-big-Data.db`.
The `email` (`lquinn@example.com`) came from the most recent update and was still in the memtable.
Cassandra had to assemble the current values from the two SSTables and the memtable.