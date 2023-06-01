# SQL

## Requests/Second and "took" based upon first and last importedAt timestamp
```sql
select round(cast(
                     (select count(*) from data_import)
                     /
                     (select extract(epoch from (
                             (select imported_at
                              from data_import
                              order by imported_at desc
                              limit 1)
                             -
                             (select imported_at
                              from data_import
                              order by imported_at
                              limit 1)))
                     ) as numeric)
           , 2) as "Requests/Second",
       round(cast(
                     (select extract(epoch from (
                             (select imported_at
                              from data_import
                              order by imported_at desc
                              limit 1)
                             -
                             (select imported_at
                              from data_import
                              order by imported_at
                              limit 1)))
                     ) / 60 as numeric)
           , 2) as "Took (minutes)",
       (select count(*) as "Total entries" from data_import);
```
