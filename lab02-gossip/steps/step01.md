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

| Syntax | Description |
| ----------- | ----------- |
| Header | Title |
| Paragraph | Text |