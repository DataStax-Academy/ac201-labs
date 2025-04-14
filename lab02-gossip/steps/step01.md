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
| genertion | Title |
| heartbeat | Text |
| LOAD | Text |
| SCHEMA | Text |
| DC | Text |
| RACK | Text |
| RELEASE_VERSION | Text |
| NET_VERSION | Text |
| HOST_ID | Text |
| RPC_READY | Text |
| NATIVE_ADDRESS_AND_PORT | Text |
| STATUS_WITH_PORT | Text |
| SSTABLE_VERSIONS | Text |
| TOKENS | Text |