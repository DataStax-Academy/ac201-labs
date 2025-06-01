In this step, you will exequte a CQL script to create and populate a table.

✅ Use the **Editor** tab to open a Theia window and examine the CQL file: `/filesystem/home/cassandra-user/build-database.cql`

The file has commands to create the `world` keyspace.
Next, there are commands to create and populate a table of countries.

Switch back to **Tab 1**

✅ Use `cqlsh` to execute the CQL file and build a database
```
nodeA/bin/cqlsh 172.30.1.10 -f build-database.cql
```{{exec}}

Verify that the table has been created and that data has been loaded.

✅ Use `cqlsh` to retrieve countries from the database.
```
nodeA/bin/cqlsh 172.30.1.10 9042 -e "SELECT * FROM world.countries;"
```{{exec}}

You should see a list of countries and the continents they are on.

![countries table](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab04/countries-cqlsh.jpg)