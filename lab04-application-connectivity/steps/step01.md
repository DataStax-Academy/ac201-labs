In this step, build a table and access it from Java and Python apps. 

Use the **Editor** tab to open an Theia window.
Examine the CQL file: `/filesystem/home/cassandra-user/build-database.cql`

Switch back to **Tab 1**

✅ Use `cqlsh` to exectue the CQL file and build a database
```
~/nodeA/bin/cqlsh 172.30.1.10 -f build-database.cql
```{{exec}}

Verify that the table has been created and that data has been loaded.

✅ Use `cqlsh` to retrieve countries from the database.
```
/home/cassandra-user/nodeA/bin/cqlsh 172.30.1.10 9042 -e "SELECT * FROM world.countries;"
```{{exec}}