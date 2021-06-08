#### Regex & multiple fields
```
GET /_search
{
  "query": {
    "bool": {
        "should": [
           {"regexp": {"json.field1": {"value": ".*111.*"}}},
           {"regexp": {"json.field2": {"value": ".*222.*"}}},
           {"match": {"kubernetes.namespace": {"query": "ingress"}}}
        ]
    }
  }
}
```