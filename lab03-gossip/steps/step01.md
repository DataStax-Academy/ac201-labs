In this step, you will verify that the cluster is up and running and then you will use `nodetool` to view *gossip*. 

✅ Use `nodetool` to verify that the cluster is running.
```
~/nodeA/bin/nodetool status
```{{exec}}

You should see all three servers running in the `U/N` state.

✅ Use `nodetool` to view *gossip*.
```
~/nodeA/bin/nodetool gossipinfo
```{{exec}}

You should see gossip information for all three servers in the cluster.

| Property | Description |
| ----------- | ----------- |
| generation | timestamp |
| heartbeat | increasing counter |
| LOAD | data on node in bytes |
| SCHEMA | schema version |
| DC | datacenter name |
| RACK | rack name |
| RELEASE_VERSION | Cassandra version |
| NET_VERSION | message protocol version |
| HOST_ID | host UUID |
| RPC_READY | ready to accept requests |
| NATIVE_ADDRESS_AND_PORT | CQL IP and port |
| STATUS_WITH_PORT | status and token value |
| SSTABLE_VERSIONS | SSTable format version |
| TOKENS | number of tokens |