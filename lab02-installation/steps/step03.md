In this step, you will start Cassandra and verify that it is running.

**Note: ** Cassandra is a *distributed* database, which means it operates across multiple nodes. For production deployments, it is essential to run multiple Cassandra instances to ensure reliability and performance. In this introductory lab you will start a single Cassandra instance.

✅ Change to the `cassandra` directory
```
cd cassandra
```{{exec}}

✅ View to the `cassandra` directory
```
ls -al
```{{exec}}

You should see `bin`, `conf`, `doc`, `lib`, `pylib`, and `tools` directories.

The Cassandra executable is in the `bin` directory and the configuration files are in the `conf` directory.

✅ Change to the `bin` directory
```
cd bin
```{{exec}}


✅ Start Cassandra in the background and send the console output to `/dev/null`.
```
./cassandra > /dev/null 2>&1 &
```{{exec}}

Nodetool is command line tool that you can us to monitor, configure or repair Cassandra.
You will use `nodetool status` that Cassandra is up and running. 

✅ Run 'nodetool status`.
```
./nodetool status
```{{exec}}

If Cassandra is not running, nodetool will fail to make a connection and you will see a message similar to one of these. 

![nodetool status](https://killrcoda-file-store.s3.amazonaws.com/AC201/Lab01/nodetool-failedtoconnect.png)

![nodetool status](https://killrcoda-file-store.s3.amazonaws.com/AC201/Lab01/nodetool-illegal.png)

If Cassandra is running you will see the status as **UN** (Up/Normal).

![nodetool status](https://killrcoda-file-store.s3.amazonaws.com/AC201/Lab01/nodetool-UN.png)


✅ If Cassandra is not running, you can run nodetool again until the Cassandra's status i s **UP**/**N**ormal. 'nodetool status`.
```
./nodetool status
```{{exec}}
