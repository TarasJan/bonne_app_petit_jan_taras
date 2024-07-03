Used Postgres [GIN index](https://www.postgresql.org/docs/9.1/textsearch-indexes.html) to achieve good text search performance


Before:

```
irb(main):001> Product.ransack(name_i_cont:"sugar").result.explain(:analyze)
  Product Load (35.5ms)  SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%sugar%'
=> 
EXPLAIN (ANALYZE) SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%sugar%'
                                                 QUERY PLAN
-------------------------------------------------------------------------------------------------------------
 Seq Scan on products  (cost=0.00..2150.21 rows=4551 width=48) (actual time=0.007..27.837 rows=3695 loops=1)
   Filter: ((name)::text ~~* '%sugar%'::text)
   Rows Removed by Filter: 92722
 Planning Time: 0.121 ms
 Execution Time: 28.025 ms
(5 rows)

irb(main):002> Product.ransack(name_i_cont:"honey").result.explain(:analyze)
  Product Load (30.1ms)  SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%honey%'
=> 
EXPLAIN (ANALYZE) SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%honey%'
                                                QUERY PLAN
-----------------------------------------------------------------------------------------------------------
 Seq Scan on products  (cost=0.00..2150.21 rows=516 width=48) (actual time=0.018..30.845 rows=557 loops=1)
   Filter: ((name)::text ~~* '%honey%'::text)
   Rows Removed by Filter: 95860
 Planning Time: 0.096 ms
 Execution Time: 30.889 ms
(5 rows)

irb(main):003> Product.ransack(name_i_cont:"berry").result.explain(:analyze)
  Product Load (27.9ms)  SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%berry%'
=> 
EXPLAIN (ANALYZE) SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%berry%'
                                               QUERY PLAN
---------------------------------------------------------------------------------------------------------
 Seq Scan on products  (cost=0.00..2150.21 rows=5 width=48) (actual time=0.022..31.143 rows=540 loops=1)
   Filter: ((name)::text ~~* '%berry%'::text)
   Rows Removed by Filter: 95877
 Planning Time: 0.132 ms
 Execution Time: 31.188 ms
(5 rows)

```


After:
```
irb(main):001> Product.ransack(name_i_cont:"sugar").result.explain(:analyze)
  Product Load (10.5ms)  SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%sugar%'
=> 
EXPLAIN (ANALYZE) SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%sugar%'
                                                              QUERY PLAN
--------------------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on products  (cost=67.27..1069.16 rows=4551 width=48) (actual time=0.553..2.334 rows=3695 loops=1)
   Recheck Cond: ((name)::text ~~* '%sugar%'::text)
   Heap Blocks: exact=859
   ->  Bitmap Index Scan on index_products_on_name  (cost=0.00..66.13 rows=4551 width=0) (actual time=0.470..0.470 rows=3695 loops=1)
         Index Cond: ((name)::text ~~* '%sugar%'::text)
 Planning Time: 0.120 ms
 Execution Time: 2.522 ms
(7 rows)

irb(main):002> Product.ransack(name_i_cont:"honey").result.explain(:analyze)
  Product Load (1.6ms)  SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%honey%'
=> 
EXPLAIN (ANALYZE) SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%honey%'
                                                             QUERY PLAN
------------------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on products  (cost=32.00..864.09 rows=516 width=48) (actual time=0.151..0.574 rows=557 loops=1)
   Recheck Cond: ((name)::text ~~* '%honey%'::text)
   Heap Blocks: exact=420
   ->  Bitmap Index Scan on index_products_on_name  (cost=0.00..31.87 rows=516 width=0) (actual time=0.110..0.110 rows=557 loops=1)
         Index Cond: ((name)::text ~~* '%honey%'::text)
 Planning Time: 0.107 ms
 Execution Time: 0.614 ms
(7 rows)

irb(main):003> Product.ransack(name_i_cont:"berry").result.explain(:analyze)
  Product Load (1.4ms)  SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%berry%'
=> 
EXPLAIN (ANALYZE) SELECT "products".* FROM "products" WHERE "products"."name" ILIKE '%berry%'
                                                            QUERY PLAN
----------------------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on products  (cost=28.04..47.01 rows=5 width=48) (actual time=0.201..0.601 rows=540 loops=1)
   Recheck Cond: ((name)::text ~~* '%berry%'::text)
   Heap Blocks: exact=357
   ->  Bitmap Index Scan on index_products_on_name  (cost=0.00..28.03 rows=5 width=0) (actual time=0.166..0.166 rows=540 loops=1)
         Index Cond: ((name)::text ~~* '%berry%'::text)
 Planning Time: 0.255 ms
 Execution Time: 0.662 ms
(7 rows)
```