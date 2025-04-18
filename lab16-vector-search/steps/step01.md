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
    vals VECTOR<float,512>
);
```{{exec}}

✅ Create the index
```
CREATE INDEX sentences_idx 
  ON sentences(vals) USING 'sai';
```{{exec}}


✅ Load the vector data
```
COPY sentences (id, sentence, vals)
  FROM '~/data/vectors.csv' WITH DELIMITER = '|';
```{{exec}}


✅ View the senteces in the database
```
SELECT sentence FROM sentences;
```{{exec}}

✅ Exit `qlsh`
```
exit
```{{exec}}

✅ Find matches for "The stew was rich and comforting."
```
nodeA/bin/cqlsh 172.30.1.10 -f data/match-food.cql
```{{exec}}

✅ Find matches for "France is on the English Channel."
```
nodeA/bin/cqlsh 172.30.1.10 -f data/match-music.cql
```{{exec}}


