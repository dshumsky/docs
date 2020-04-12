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