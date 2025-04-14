In this step, you will use `cqlsh` to create a keyspace and a table.
Then, you will populate the table and performa simle query.

✅ Use `cqlsh` to connect to Cassandra
```
~/nodeA/bin/cqlsh
```{{exec}}

Verify that the version is 11.0.23

While connected through the terminal, you should verify the user account you are logged in with.

✅ Check the account
```
whoami
```{{exec}}

You are currently logged in as a *root* user.

Cassandra should *never* run under a user account with *root* privileges.
Fortunately, the lab environment setup created a new user in a new group to run Cassandra.

**User** : cassandra-user<br>
**Group**: cassandra


✅ Switch to *cassandra-user*.
```
su cassandra-user
```{{exec}}

✅ Navigate to cassandra-user's home directory.
```
cd /home/cassandra-user
```{{exec}}

You are now ready to install Cassandra into `/home/cassandra-user`.