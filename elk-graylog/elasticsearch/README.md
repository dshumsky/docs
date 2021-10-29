### ElasticSearch

```bash
GET _cluster/health?pretty
GET _cluster/health?level=indices&pretty'
GET _cluster/allocation/explain?pretty'
GET _cluster/reroute?retry_failed

GET _cluster/health/?level=shards&pretty'
GET _cat/shards?h=index,shard,prirep,state,unassigned.reason' | grep UNASSIGNED

GET $INDEX/_settings?pretty

PUT $INDEX/_settings?pretty
{
  "index": {
    "blocks": {
      "read_only_allow_delete": "false"
    }
  }
}'

PUT $INDEX/_settings?pretty
{
  "index" : {
     "number_of_replicas" : 0
  }
}'

PUT $INDEX/_settings?pretty
{
  "index" : {
     "blocks.read_only" : false
  }
}'

GET _search
{
  "query": {
    "match": {
      "kubernetes.container.name": "datadog"
    }
  }
}```

#### Delete data 

```bash
curl -XPOST 'localhost:9200/$INDEX/_delete_by_query
  -H "Content-Type: application/json" \
  -d '{
        "query": {
          "match": {
            "kubernetes.container.name": "datadog"
          }
        }
      }'

curl -XPOST 'localhost:9200/filebeat-7.5.1-2020.03.14-000003/_forcemerge?only_expunge_deletes=true&pretty'
```

#### Archive/Restore
```shell script
GET /_cat/snapshots/repo1?v

PUT /_snapshot/repo1/index1
{
 "indices": "index1"
}
```

#### Recover from `max_shards_per_node`
<https://berrynetworks.wordpress.com/tag/max_shards_per_node/>
<https://stackoverflow.com/questions/50609417/elasticsearch-error-cluster-block-exception-forbidden-12-index-read-only-all>

PUT /_all/_settings 
{"index.blocks.read_only_allow_delete": null}

#### Recover from Out-Of-Space
```
- Delete unnessary indexes
- Wait for free space

- Unblock read-only indexes in ELK
PUT /<index>/_settings
{
  "index.blocks.read_only_allow_delete": null
}
PUT /_all/_settings
{
  "index.blocks.read_only_allow_delete": null
}

- Rollover manually
POST /filebeat-7.5.1/_rollover
{
  "conditions": {
    "max_age":   "1d",
    "max_docs":  1000,
    "max_size": "1gb"
  }
}

```