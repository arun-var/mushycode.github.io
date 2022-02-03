---
layout: post
title: "Commonly used Elasticsearch REST APIs at work"
date:  2020-05-13 13:13:55
categories: [elasticsearch, rest]
---

This is a simple post listing the most used Elasticsearch rest APIs at work for my reference and maybe others.


```
curl "localhost:9200/_cat/indices"
```

```
curl "localhost:9200/_cat/shards"
```

```
curl "localhost:9200/_nodes?pretty"
```

```
curl "localhost:9200/_cluster/allocation/explain?pretty"
```

```
curl -s 'localhost:9200/_cat/allocation?v'
```

```
curl -XPOST localhost:9200/_cluster/reroute?retry_failed=true
```

```
curl -X POST localhost:9200/_reindex \
-H 'cache-control: no-cache' \
-H 'content-type: application/json' \
-d '{
  "source": {
    "index": "<<index_old_ones_with_data>>",
    "query": {
        "match_all": {}
    }
  },
  "dest": {
    "index": "<<new_index_with_new_mapping>>"
  }
}'
```

```
curl -X POST localhost:9200/_reindex \
-H 'cache-control: no-cache' \
-H 'content-type: application/json' \
-d '{
  "source": {
    "remote": {
      "host": "http://<some-ip>:9200"
    },
    "index": "<<index_old_ones_with_data>>",
    "query": {
        "match_all": {}
    }
  },
  "dest": {
    "index": "<<new_index_with_new_mapping>>"
  }
}'
```

```
curl -X POST "localhost:9200/<index_name>/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "<field>": "<field-value>"
    }
  }
}
'
```

```
curl -X POST "localhost:9200/<index_name>/_delete_by_query?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "<field>": "<field-value>"
    }
  }
}
'
```

PS: I will add description for each soon
