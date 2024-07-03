Before:

```
EXPLAIN (ANALYZE) SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%sugar%'
                                              QUERY PLAN
------------------------------------------------------------------------------------------------------
 Seq Scan on products  (cost=0.00..25.51 rows=66 width=53) (actual time=0.009..0.470 rows=34 loops=1)
   Filter: ((name)::text ~~* '%sugar%'::text)
   Rows Removed by Filter: 1047
 Planning Time: 0.095 ms
 Execution Time: 0.492 ms
(5 rows)
```


After:
```

```