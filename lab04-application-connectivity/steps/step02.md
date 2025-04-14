In this step you will build and run a Java application that retrieves data from the `countries` table.

The Java application has two parts:

- `pom.xml` (a Maven build file)
- `CassandraClient.java` (the Java source file)

Use the **Editor** tab to open a Theia window and examine the Maven build file: `/filesystem/home/cassandra-user/java-app/pom.xml`

You should see the dependency for the DataStax oss Cassandra driver, version 4.16.0.

Use the **Editor** tab to open a Theia window and examine the Java source file: `/filesystem/home/cassandra-user/java-app/src/main/java/som.example/CassandraClient.java`

You will see the `CQLSession` builder defining the IP address, keyspace and table name.
Next you will see the query: `SELECT id, continent, country FROM countries`.
After executing the query, the application iterates through the results and displays them.

In **Tab 1** navigate to `/home/cassandra-user/java-app`.

✅ Use `cqlsh` to exectue the CQL file and build a database
```
cd /home/cassandra-user/java-app
```{{exec}}

✅ Use maven to retrieve dependencies, compile, and run the application.
```
mvn clean compile exec:java -Dexec.mainClass="com.example.CassandraClient"
```{{exec}}

You should see *lots* of text scroll by.
Maven has to load all the necessary Java dependencies before it can build your application.
Finally, after lading dependencies, Maven will build and execute yout app. 
You should see a list of countries.

![Java client](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab04/countries-java.jpg)