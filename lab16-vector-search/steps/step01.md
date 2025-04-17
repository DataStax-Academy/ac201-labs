✅ Use `cqlsh` to connect to the database
```
nodeA/bin/cqlsh 172.30.1.10
```{{exec}}

Create a keyspace in the cluster.

✅ Create the `vectors` keyspace
```
CREATE KEYSPACE vectors WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
};
```{{exec}}

✅ Use the `vectors` keyspace
```
USE vectors;
```{{exec}}

The data you will use in this lab consists of 40 English sentences and ther 512d vector encodings from the Universal Sentence Encoder.

✅ Create the table
```
CREATE TABLE sentences (
    id int PRIMARY KEY,
    sentence text,
    vals VECTOR<int,512>
);
```{{exec}}

✅ Load the vector data
```
COPY sentences (id, sentence, vals)
  FROM '~/data/vectors.csv' WITH DELIMITER = '|';
```{{exec}}


✅ INSERT
```
INSERT INTO bar(name, vals) VALUES('David',[1,2,3]);
INSERT INTO bar(name, vals) VALUES('David',[1,2,3]);
```{{exec}}

✅ Display the state data
```
SELECT * FROM bar;
```{{exec}}