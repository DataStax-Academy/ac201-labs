`Ctrl-C`{{exec interrupt}}

<details class="katapod-details">
  <summary>Solution</summary>

```cql
CONSISTENCY ONE;

SELECT * FROM killrvideo.videos_by_tag WHERE tag = 'cassandra';
```