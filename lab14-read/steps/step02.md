In this step you will look at the `data` directories before and after flushing the memtable.

✅ Retrieve the data
```
nodeA/tools/bin/sstabledump \
  nodeA/data/data/club/members-*/nb-1-big-Data.db
```{{exec}}


✅ Retrieve the data
```
nodeA/tools/bin/sstabledump \
  nodeA/data/data/club/members-*/nb-2-big-Data.db
```{{exec}}

✅ Retrieve the data
```
nodeA/bin/cqlsh 172.30.1.10 \
  -e "SELECT * FROM club.members;"
```{{exec}}