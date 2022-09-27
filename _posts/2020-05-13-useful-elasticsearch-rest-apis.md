---
layout: post
title: "Commonly used Elasticsearch REST APIs at work"
date:  2020-05-13 13:13:55
tags: elasticsearch rest-api
categories: elasticsearch
image: /assets/article_images/2020-05-13-useful-elasticsearch-rest-apis/elasticsearch.jpg
---

## Helpful Elasticsearch APIs

This is a simple post listing the Elasticsearch rest APIs that I use most at work.

### List all indices
{% highlight sh %}
curl "localhost:9200/_cat/indices"
{% endhighlight %}

### List all shards
{% highlight sh %}
curl "localhost:9200/_cat/shards"
{% endhighlight %}

### List all elasticserach nodes
{% highlight sh %}
curl "localhost:9200/_nodes?pretty"
{% endhighlight %}

{% highlight sh %}
curl "localhost:9200/_cluster/allocation/explain?pretty"
{% endhighlight %}

{% highlight sh %}
curl -s 'localhost:9200/_cat/allocation?v'
{% endhighlight %}

{% highlight sh %}
curl -XPOST localhost:9200/_cluster/reroute?retry_failed=true
{% endhighlight %}

{% highlight sh %}
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
{% endhighlight %}

{% highlight sh %}
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
{% endhighlight %}

{% highlight sh %}
curl -X POST "localhost:9200/<index_name>/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "<field>": "<field-value>"
    }
  }
}
'
{% endhighlight %}

{% highlight sh %}
curl -X POST "localhost:9200/<index_name>/_delete_by_query?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "<field>": "<field-value>"
    }
  }
}
'
{% endhighlight %}

PS: I will add description for each soon
