# Elasticsearch

## Troubleshooting

### Red cluster status (all shards unassigned)

1. To find the error you can try the following command and see if there are any exceptions in one of the shards:
    ```shell
    POST _cluster/reroute
    ```
    Source: https://www.elastic.co/guide/en/elasticsearch/reference/current/red-yellow-cluster-status.html
2. Fix the error. Common mistakes:
    1. The extension (Elastic Cloud) for synonyms and mcr is missing so that the indices can't find the files on the nodes.
4. Once the error is fixed you can restart the shard allocation manually in case the shards didn't got re-allocated automatically:
    ```shell
    POST _cluster/reroute?retry_failed=true
    ```
    Source: https://stackoverflow.com/a/69799545/9478795
