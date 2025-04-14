In this step you will run a Python application that retrieves data from the `countries` table.

Use the **Editor** tab to open a Theia window and examine the Python file: `/filesystem/home/cassandra-user/
python-app/CassandraClient.py`


✅ Change to the `python-app` directory.
```
cd /home/cassandra-user/python-app
```{{exec}}


✅ Use `pip` to the Python driver for Cassandra
```
/opt/python3.11/bin/pip3.11 install cassandra-driver
```{{exec}}


✅ Run the app in the Python interpreter
```
python /home/cassandra-user/python-app/CassandraClient.py
```{{exec}}

You should see the list of coiuntries.

![Java client](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab04/countries-python.jpg)