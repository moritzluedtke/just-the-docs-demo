# Prometheus

## Ingestion rate

```
sort_desc(sum_over_time(scrape_samples_scraped[5m]) / 300)
```
